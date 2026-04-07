#!/usr/bin/env python3
"""Minimal host-side writer for Sprint 4 heartbeat.write."""

from __future__ import annotations

import argparse
import json
import os
import re
import stat
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable

MANAGED_BY = "openclaw"
AGENT_ZONE = "Heartbeat"
ALLOWED_RELATIVE_DIR = Path("Agent/Heartbeat")
ALLOWED_OPERATION = "heartbeat.write"
ALLOWED_HEARTBEAT_TYPES = {"runtime-status"}
MAX_COMPONENT_LEN = 48
MAX_FILENAME_LEN = 128
AUDIT_LOG_NAME = "heartbeat-writer-audit.jsonl"


class WriterError(RuntimeError):
    """Raised when the writer must stop for safety reasons."""


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Write a single create-only heartbeat note inside Agent/Heartbeat."
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    write_parser = subparsers.add_parser(ALLOWED_OPERATION)
    write_parser.add_argument("--vault-root", required=True)
    write_parser.add_argument("--audit-root", required=True)
    write_parser.add_argument(
        "--heartbeat-type",
        required=True,
        choices=sorted(ALLOWED_HEARTBEAT_TYPES),
    )
    write_parser.add_argument("--run-id", required=True)
    write_parser.add_argument("--source-ref", action="append", default=[])
    write_parser.add_argument(
        "--context",
        default="Manual Sprint 4 runtime-status heartbeat execution.",
    )
    write_parser.add_argument(
        "--result",
        default="A single create-only heartbeat note was requested.",
    )
    return parser.parse_args()


def utc_now() -> datetime:
    return datetime.now(timezone.utc)


def timestamp_for_filename(now: datetime) -> str:
    return now.strftime("%Y%m%dT%H%M%SZ")


def timestamp_for_frontmatter(now: datetime) -> str:
    return now.strftime("%Y-%m-%dT%H:%M:%SZ")


def sanitize_component(value: str, label: str) -> str:
    cleaned = re.sub(r"[^A-Za-z0-9._-]+", "-", value.strip())
    cleaned = cleaned.strip("._-")
    if not cleaned:
        raise WriterError(f"{label} is empty after sanitization")
    if len(cleaned) > MAX_COMPONENT_LEN:
        raise WriterError(f"{label} exceeds {MAX_COMPONENT_LEN} characters")
    if "/" in cleaned or "\\" in cleaned or ".." in cleaned:
        raise WriterError(f"{label} contains invalid path content")
    return cleaned


def sanitize_source_refs(values: Iterable[str]) -> list[str]:
    sanitized: list[str] = []
    for raw_value in values:
        value = raw_value.strip()
        if not value:
            raise WriterError("source-ref cannot be empty")
        if "\x00" in value or "\n" in value or "\r" in value:
            raise WriterError("source-ref contains invalid control characters")
        sanitized.append(value)
    return sanitized


def sanitize_body_text(value: str, label: str) -> str:
    if "\x00" in value:
        raise WriterError(f"{label} contains invalid control characters")
    cleaned = value.strip()
    if not cleaned:
        raise WriterError(f"{label} cannot be empty")
    return cleaned


def ensure_existing_directory(path: Path, label: str) -> None:
    try:
        path_lstat = path.lstat()
    except FileNotFoundError as exc:
        raise WriterError(f"{label} does not exist: {path}") from exc
    if stat.S_ISLNK(path_lstat.st_mode):
        raise WriterError(f"{label} must not be a symlink: {path}")
    if not stat.S_ISDIR(path_lstat.st_mode):
        raise WriterError(f"{label} must be a directory: {path}")


def assert_no_symlinks(path: Path, label: str) -> None:
    current = Path(path.anchor) if path.is_absolute() else Path(".")
    for part in path.parts[1:] if path.is_absolute() else path.parts:
        current = current / part
        try:
            path_lstat = current.lstat()
        except FileNotFoundError:
            break
        if stat.S_ISLNK(path_lstat.st_mode):
            raise WriterError(f"{label} contains a symlink component: {current}")


def resolve_existing_directory(path_str: str, label: str) -> Path:
    candidate = Path(path_str)
    if not candidate.is_absolute():
        raise WriterError(f"{label} must be an absolute path")
    assert_no_symlinks(candidate, label)
    resolved = candidate.resolve(strict=True)
    ensure_existing_directory(resolved, label)
    return resolved


def is_relative_to(path: Path, parent: Path) -> bool:
    try:
        path.relative_to(parent)
        return True
    except ValueError:
        return False


def ensure_directory(path: Path, label: str) -> None:
    if path.exists():
        ensure_existing_directory(path, label)
        return
    parent = path.parent
    ensure_existing_directory(parent, f"{label} parent")
    assert_no_symlinks(parent, f"{label} parent")
    try:
        path.mkdir(mode=0o750)
    except FileExistsError as exc:
        raise WriterError(f"{label} already exists but is not a directory: {path}") from exc
    ensure_existing_directory(path, label)


def build_note_name(timestamp_utc: str, heartbeat_type: str, run_id: str) -> str:
    filename = f"{timestamp_utc}_{heartbeat_type}_{run_id}.md"
    if len(filename) > MAX_FILENAME_LEN:
        raise WriterError(f"filename exceeds {MAX_FILENAME_LEN} characters")
    if not filename.endswith(".md"):
        raise WriterError("filename must end with .md")
    return filename


def dump_yaml_scalar(value: str) -> str:
    return json.dumps(value, ensure_ascii=True)


def build_markdown(
    now: datetime,
    run_id: str,
    heartbeat_type: str,
    source_refs: list[str],
    context: str,
    result: str,
) -> str:
    timestamp_utc = timestamp_for_frontmatter(now)
    frontmatter_lines = [
        "---",
        f"managed_by: {MANAGED_BY}",
        f"agent_zone: {AGENT_ZONE}",
        f"run_id: {dump_yaml_scalar(run_id)}",
        f"created_at_utc: {dump_yaml_scalar(timestamp_utc)}",
        f"updated_at_utc: {dump_yaml_scalar(timestamp_utc)}",
        f"source_refs: {json.dumps(source_refs, ensure_ascii=True)}",
        "human_review_status: not_required",
        f"heartbeat_type: {dump_yaml_scalar(heartbeat_type)}",
        "---",
        "",
        f"# Heartbeat {heartbeat_type}",
        "",
        "## Contexto",
        "",
        context.strip(),
        "",
        "## Resultado",
        "",
        result.strip(),
        "",
        "## Trazabilidad",
        "",
        f"- operation: `{ALLOWED_OPERATION}`",
        f"- run_id: `{run_id}`",
        f"- heartbeat_type: `{heartbeat_type}`",
        f"- created_at_utc: `{timestamp_utc}`",
        f"- source_refs: `{json.dumps(source_refs, ensure_ascii=True)}`",
        "",
    ]
    return "\n".join(frontmatter_lines)


def write_create_only(path: Path, content: str, label: str) -> None:
    flags = os.O_WRONLY | os.O_CREAT | os.O_EXCL
    nofollow = getattr(os, "O_NOFOLLOW", 0)
    fd = None
    try:
        fd = os.open(path, flags | nofollow, 0o660)
        with os.fdopen(fd, "w", encoding="utf-8", newline="\n") as handle:
            fd = None
            handle.write(content)
    except FileExistsError as exc:
        raise WriterError(f"{label} already exists: {path}") from exc
    except OSError as exc:
        raise WriterError(f"failed to write {label}: {path}: {exc}") from exc
    finally:
        if fd is not None:
            os.close(fd)


def prepare_audit_root(audit_root: Path, vault_root: Path) -> Path:
    if not audit_root.is_absolute():
        raise WriterError("audit-root must be an absolute path")
    assert_no_symlinks(audit_root, "audit-root")
    normalized = audit_root.resolve()
    if is_relative_to(normalized, vault_root):
        raise WriterError("audit-root must be outside the vault")
    ensure_directory(normalized, "audit-root")
    return normalized


def append_audit_record(audit_root: Path, record: dict[str, object]) -> Path:
    audit_log_path = audit_root / AUDIT_LOG_NAME
    if audit_log_path.exists():
        audit_lstat = audit_log_path.lstat()
        if stat.S_ISLNK(audit_lstat.st_mode):
            raise WriterError(f"audit log must not be a symlink: {audit_log_path}")
        if not stat.S_ISREG(audit_lstat.st_mode):
            raise WriterError(f"audit log must be a regular file: {audit_log_path}")

    payload = json.dumps(record, sort_keys=True, ensure_ascii=True) + "\n"
    flags = os.O_WRONLY | os.O_CREAT | os.O_APPEND
    nofollow = getattr(os, "O_NOFOLLOW", 0)
    fd = None
    try:
        fd = os.open(audit_log_path, flags | nofollow, 0o640)
        with os.fdopen(fd, "a", encoding="utf-8", newline="\n") as handle:
            fd = None
            handle.write(payload)
    except OSError as exc:
        raise WriterError(f"failed to write audit log: {audit_log_path}: {exc}") from exc
    finally:
        if fd is not None:
            os.close(fd)

    return audit_log_path


def perform_heartbeat_write(args: argparse.Namespace) -> int:
    now = utc_now()
    vault_root = resolve_existing_directory(args.vault_root, "vault-root")
    destination_candidate = vault_root / ALLOWED_RELATIVE_DIR
    assert_no_symlinks(destination_candidate, "destination directory")
    ensure_existing_directory(destination_candidate, "destination directory")
    destination_dir = destination_candidate.resolve(strict=True)
    if not is_relative_to(destination_dir, vault_root):
        raise WriterError("destination directory is outside the vault")

    run_id = sanitize_component(args.run_id, "run-id")
    heartbeat_type = sanitize_component(args.heartbeat_type, "heartbeat-type")
    if heartbeat_type not in ALLOWED_HEARTBEAT_TYPES:
        raise WriterError(f"unsupported heartbeat-type: {heartbeat_type}")

    source_refs = sanitize_source_refs(args.source_ref)
    context = sanitize_body_text(args.context, "context")
    result = sanitize_body_text(args.result, "result")
    audit_root = prepare_audit_root(Path(args.audit_root), vault_root)
    note_name = build_note_name(timestamp_for_filename(now), heartbeat_type, run_id)
    note_path = destination_dir / note_name
    if note_path.parent != destination_dir:
        raise WriterError("computed note path escaped destination directory")
    if note_path.exists():
        raise WriterError(f"destination already exists: {note_path}")

    markdown = build_markdown(
        now=now,
        run_id=run_id,
        heartbeat_type=heartbeat_type,
        source_refs=source_refs,
        context=context,
        result=result,
    )
    write_create_only(note_path, markdown, "heartbeat note")

    audit_record = {
        "event_at_utc": timestamp_for_frontmatter(now),
        "managed_by": MANAGED_BY,
        "agent_zone": AGENT_ZONE,
        "operation": ALLOWED_OPERATION,
        "heartbeat_type": heartbeat_type,
        "run_id": run_id,
        "note_path": str(note_path),
        "source_refs": source_refs,
    }
    audit_log_path = append_audit_record(audit_root, audit_record)

    print(str(note_path))
    print(str(audit_log_path))
    return 0


def main() -> int:
    args = parse_args()
    try:
        if args.command != ALLOWED_OPERATION:
            raise WriterError(f"unsupported operation: {args.command}")
        return perform_heartbeat_write(args)
    except WriterError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
