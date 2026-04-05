#!/usr/bin/env bash
set -Eeuo pipefail

ACTION="${1:-plan}"
NETWORK_NAME="${NETWORK_NAME:-agents_net}"
DOCKER_CHAIN="${DOCKER_CHAIN:-DOCKER-USER}"
CHAIN_NAME="${CHAIN_NAME:-OPENCLAW-EGRESS}"
COMMENT_TAG="${COMMENT_TAG:-openclaw-egress-allowlist}"
EXPECTED_AGENTS_SUBNET="${EXPECTED_AGENTS_SUBNET:-172.22.0.0/16}"
EXPECTED_AGENTS_GATEWAY="${EXPECTED_AGENTS_GATEWAY:-172.22.0.1}"
ALLOWED_HOST_TCP_PORT="${ALLOWED_HOST_TCP_PORT:-11440}"
ALLOW_OLLAMA_DIRECT="${ALLOW_OLLAMA_DIRECT:-0}"
OLLAMA_DIRECT_PORT="${OLLAMA_DIRECT_PORT:-11434}"
ALLOW_EXISTING_DOCKER_USER_RULES="${ALLOW_EXISTING_DOCKER_USER_RULES:-0}"
BACKUP_DIR="${BACKUP_DIR:-/var/backups/openclaw-egress}"
RUN_ID="${RUN_ID:-$(date -u +%Y%m%dT%H%M%SZ)}"

AGENTS_SUBNET=""
AGENTS_GATEWAY=""
BACKUP_PREFIX=""

usage() {
  cat <<'EOF'
Uso:
  openclaw_egress_allowlist.sh [plan|apply|verify|rollback]

Variables opcionales:
  ALLOW_OLLAMA_DIRECT=1              Permite 172.22.0.1:11434/tcp además de 11440.
  ALLOW_EXISTING_DOCKER_USER_RULES=1 Omite el abort si DOCKER-USER ya tiene reglas no previstas.
  BACKUP_DIR=/ruta                   Cambia la ruta de backups.
EOF
}

log() {
  printf '[openclaw-egress] %s\n' "$*"
}

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

require_root() {
  if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
    fail "este script debe ejecutarse como root"
  fi
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "falta comando requerido: $1"
}

detect_network() {
  local actual_subnet actual_gateway

  actual_subnet="$(docker network inspect "${NETWORK_NAME}" --format '{{range .IPAM.Config}}{{.Subnet}}{{end}}' 2>/dev/null || true)"
  actual_gateway="$(docker network inspect "${NETWORK_NAME}" --format '{{range .IPAM.Config}}{{.Gateway}}{{end}}' 2>/dev/null || true)"

  [[ -n "${actual_subnet}" ]] || fail "no se pudo resolver la subnet de ${NETWORK_NAME}"
  [[ -n "${actual_gateway}" ]] || fail "no se pudo resolver el gateway de ${NETWORK_NAME}"

  if [[ "${actual_subnet}" != "${EXPECTED_AGENTS_SUBNET}" ]]; then
    fail "subnet inesperada para ${NETWORK_NAME}: ${actual_subnet} != ${EXPECTED_AGENTS_SUBNET}"
  fi

  if [[ "${actual_gateway}" != "${EXPECTED_AGENTS_GATEWAY}" ]]; then
    fail "gateway inesperado para ${NETWORK_NAME}: ${actual_gateway} != ${EXPECTED_AGENTS_GATEWAY}"
  fi

  AGENTS_SUBNET="${actual_subnet}"
  AGENTS_GATEWAY="${actual_gateway}"
}

check_docker_chain() {
  iptables -S "${DOCKER_CHAIN}" >/dev/null 2>&1 || fail "no existe la cadena ${DOCKER_CHAIN}"
}

check_unmanaged_docker_user_rules() {
  local unmanaged

  unmanaged="$(
    iptables -S "${DOCKER_CHAIN}" \
      | grep -Fv -- "-N ${DOCKER_CHAIN}" \
      | grep -Fv -- "-A ${DOCKER_CHAIN} -j RETURN" \
      | grep -Fv -- "-A ${DOCKER_CHAIN} -s ${AGENTS_SUBNET} -j ${CHAIN_NAME}" \
      || true
  )"

  if [[ -n "${unmanaged}" ]] && [[ "${ALLOW_EXISTING_DOCKER_USER_RULES}" != "1" ]]; then
    printf '%s\n' "${unmanaged}" >&2
    fail "DOCKER-USER ya contiene reglas no gestionadas por este cambio; abortando"
  fi
}

prechecks_common() {
  require_root
  require_cmd docker
  require_cmd iptables
  require_cmd iptables-save
  detect_network
  check_docker_chain
}

prechecks_strict_apply() {
  prechecks_common
  check_unmanaged_docker_user_rules
}

create_backup() {
  local metadata_file

  mkdir -p "${BACKUP_DIR}"
  BACKUP_PREFIX="${BACKUP_DIR}/${RUN_ID}"

  iptables-save > "${BACKUP_PREFIX}_iptables.save"
  docker network inspect "${NETWORK_NAME}" > "${BACKUP_PREFIX}_${NETWORK_NAME}.json"

  metadata_file="${BACKUP_PREFIX}_metadata.txt"
  cat > "${metadata_file}" <<EOF
run_id=${RUN_ID}
network_name=${NETWORK_NAME}
agents_subnet=${AGENTS_SUBNET}
agents_gateway=${AGENTS_GATEWAY}
docker_chain=${DOCKER_CHAIN}
chain_name=${CHAIN_NAME}
allowed_host_tcp_port=${ALLOWED_HOST_TCP_PORT}
allow_ollama_direct=${ALLOW_OLLAMA_DIRECT}
ollama_direct_port=${OLLAMA_DIRECT_PORT}
EOF
}

ensure_chain_exists() {
  iptables -nL "${CHAIN_NAME}" >/dev/null 2>&1 || iptables -N "${CHAIN_NAME}"
}

populate_chain() {
  local gateway_cidr

  gateway_cidr="${AGENTS_GATEWAY}/32"

  iptables -F "${CHAIN_NAME}"
  iptables -A "${CHAIN_NAME}" -m comment --comment "${COMMENT_TAG}" -m conntrack --ctstate ESTABLISHED,RELATED -j RETURN
  iptables -A "${CHAIN_NAME}" -m comment --comment "${COMMENT_TAG}" -d "${gateway_cidr}" -p tcp --dport "${ALLOWED_HOST_TCP_PORT}" -j RETURN

  if [[ "${ALLOW_OLLAMA_DIRECT}" == "1" ]]; then
    iptables -A "${CHAIN_NAME}" -m comment --comment "${COMMENT_TAG}" -d "${gateway_cidr}" -p tcp --dport "${OLLAMA_DIRECT_PORT}" -j RETURN
  fi

  iptables -A "${CHAIN_NAME}" -m comment --comment "${COMMENT_TAG}" -j DROP
}

ensure_jump() {
  iptables -C "${DOCKER_CHAIN}" -s "${AGENTS_SUBNET}" -j "${CHAIN_NAME}" >/dev/null 2>&1 \
    || iptables -I "${DOCKER_CHAIN}" 1 -s "${AGENTS_SUBNET}" -j "${CHAIN_NAME}"
}

verify_rules() {
  local first_docker_rule gateway_cidr

  gateway_cidr="${AGENTS_GATEWAY}/32"
  first_docker_rule="$(iptables -S "${DOCKER_CHAIN}" | grep -F -- "-A ${DOCKER_CHAIN}" | head -n 1 || true)"

  iptables -C "${DOCKER_CHAIN}" -s "${AGENTS_SUBNET}" -j "${CHAIN_NAME}" >/dev/null 2>&1 \
    || fail "falta el salto ${DOCKER_CHAIN} -> ${CHAIN_NAME}"
  [[ "${first_docker_rule}" == "-A ${DOCKER_CHAIN} -s ${AGENTS_SUBNET} -j ${CHAIN_NAME}" ]] \
    || fail "el salto ${DOCKER_CHAIN} -> ${CHAIN_NAME} no es la primera regla efectiva"
  iptables -C "${CHAIN_NAME}" -m conntrack --ctstate ESTABLISHED,RELATED -j RETURN >/dev/null 2>&1 \
    || fail "falta la regla ESTABLISHED,RELATED en ${CHAIN_NAME}"
  iptables -C "${CHAIN_NAME}" -d "${gateway_cidr}" -p tcp --dport "${ALLOWED_HOST_TCP_PORT}" -j RETURN >/dev/null 2>&1 \
    || fail "falta la allowlist a ${gateway_cidr}:${ALLOWED_HOST_TCP_PORT}"
  iptables -C "${CHAIN_NAME}" -j DROP >/dev/null 2>&1 \
    || fail "falta la regla final DROP en ${CHAIN_NAME}"

  if [[ "${ALLOW_OLLAMA_DIRECT}" == "1" ]]; then
    iptables -C "${CHAIN_NAME}" -d "${gateway_cidr}" -p tcp --dport "${OLLAMA_DIRECT_PORT}" -j RETURN >/dev/null 2>&1 \
      || fail "falta la allowlist opcional a ${gateway_cidr}:${OLLAMA_DIRECT_PORT}"
  fi
}

print_runtime_summary() {
  cat <<EOF
network_name=${NETWORK_NAME}
agents_subnet=${AGENTS_SUBNET}
agents_gateway=${AGENTS_GATEWAY}
docker_chain=${DOCKER_CHAIN}
chain_name=${CHAIN_NAME}
allowed_host_tcp_port=${ALLOWED_HOST_TCP_PORT}
allow_ollama_direct=${ALLOW_OLLAMA_DIRECT}
ollama_direct_port=${OLLAMA_DIRECT_PORT}
backup_prefix=${BACKUP_PREFIX:-not-created}
EOF
}

plan_mode() {
  prechecks_strict_apply
  print_runtime_summary
  echo
  echo "Reglas previstas:"
  echo "  -I ${DOCKER_CHAIN} 1 -s ${AGENTS_SUBNET} -j ${CHAIN_NAME}"
  echo "  -A ${CHAIN_NAME} -m conntrack --ctstate ESTABLISHED,RELATED -j RETURN"
  echo "  -A ${CHAIN_NAME} -d ${AGENTS_GATEWAY}/32 -p tcp --dport ${ALLOWED_HOST_TCP_PORT} -j RETURN"

  if [[ "${ALLOW_OLLAMA_DIRECT}" == "1" ]]; then
    echo "  -A ${CHAIN_NAME} -d ${AGENTS_GATEWAY}/32 -p tcp --dport ${OLLAMA_DIRECT_PORT} -j RETURN"
  fi

  echo "  -A ${CHAIN_NAME} -j DROP"
}

apply_mode() {
  prechecks_strict_apply
  create_backup
  ensure_chain_exists
  populate_chain
  ensure_jump
  verify_rules
  print_runtime_summary
  echo
  iptables -S "${DOCKER_CHAIN}"
  echo
  iptables -S "${CHAIN_NAME}"
}

verify_mode() {
  prechecks_common
  iptables -S "${CHAIN_NAME}" >/dev/null 2>&1 || fail "no existe la cadena ${CHAIN_NAME}"
  verify_rules
  print_runtime_summary
  echo
  iptables -S "${DOCKER_CHAIN}"
  echo
  iptables -S "${CHAIN_NAME}"
}

rollback_mode() {
  prechecks_common
  create_backup

  while iptables -C "${DOCKER_CHAIN}" -s "${AGENTS_SUBNET}" -j "${CHAIN_NAME}" >/dev/null 2>&1; do
    iptables -D "${DOCKER_CHAIN}" -s "${AGENTS_SUBNET}" -j "${CHAIN_NAME}"
  done

  if iptables -nL "${CHAIN_NAME}" >/dev/null 2>&1; then
    iptables -F "${CHAIN_NAME}"
    iptables -X "${CHAIN_NAME}"
  fi

  print_runtime_summary
  echo
  iptables -S "${DOCKER_CHAIN}"
}

main() {
  case "${ACTION}" in
    plan)
      plan_mode
      ;;
    apply)
      apply_mode
      ;;
    verify)
      verify_mode
      ;;
    rollback)
      rollback_mode
      ;;
    -h|--help|help)
      usage
      ;;
    *)
      usage
      fail "acción no soportada: ${ACTION}"
      ;;
  esac
}

main "$@"
