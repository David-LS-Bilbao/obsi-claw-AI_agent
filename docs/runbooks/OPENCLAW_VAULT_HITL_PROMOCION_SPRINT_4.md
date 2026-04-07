# OPENCLAW_VAULT_HITL_PROMOCION_SPRINT_4.md

## Propósito

Fijar la postura de HITL para Sprint 4 sin abrir promoción automática desde `Drafts_Agent`.

## Estado

Documento repo-side.

No demuestra flujo operativo real en host.
Toda secuencia efectiva de promoción sigue `pendiente de verificación en host`.

## Regla base

`draft.write` termina en `Agent/Drafts_Agent/` con:

- `human_review_status: pending_human_review`;
- `proposed_target_path` solo textual;
- cero promoción automática;
- cero escritura fuera de zonas controladas.

## Qué sí autoriza Sprint 4

- generar un borrador revisable;
- dejar trazabilidad mínima;
- proponer un destino textual;
- separar claramente staged request, borrador y promoción.

## Qué no autoriza Sprint 4

- mover el draft a notas núcleo;
- copiar contenido a proyectos o áreas de forma automática;
- borrar el staged request o el draft original;
- mutar taxonomía del vault;
- introducir watcher o timer;
- abrir `report.write`.

## Flujo lógico esperado

1. existe un staged request válido en `Agent/Inbox_Agent/STAGED_INPUT.md`;
2. `draft.write` genera un único draft create-only en `Agent/Drafts_Agent/`;
3. un humano revisa el borrador;
4. cualquier promoción posterior se decide fuera de este writer.

## Consecuencia operativa

Mientras no exista un flujo de promoción validado aparte:

- `pending_human_review` no debe ser alterado automáticamente;
- `proposed_target_path` no debe ejecutarse como acción;
- el writer de drafts no debe escribir en notas núcleo ni en `Agent/Reports_Agent/`.

## Pendiente de verificación en host

- secuencia manual exacta de promoción posterior al draft;
- permisos efectivos para una promoción humana o semiautomatizada;
- ubicación canónica de los documentos promovidos;
- evidencia mínima requerida para auditar una promoción futura.
