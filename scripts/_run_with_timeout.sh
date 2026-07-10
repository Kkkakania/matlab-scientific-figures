#!/usr/bin/env bash

run_with_timeout() {
  local seconds="$1"
  shift

  if [[ ! "$seconds" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    echo "Invalid timeout seconds: $seconds" >&2
    return 2
  fi

  if [[ "$seconds" =~ ^0+([.]0+)?$ ]]; then
    "$@"
    return
  fi

  if ! command -v python3 >/dev/null 2>&1; then
    echo "python3 not found; running command without timeout guard." >&2
    "$@"
    return
  fi

  python3 - "$seconds" "$@" <<'PY'
import os
import signal
import subprocess
import sys
import time

seconds = float(sys.argv[1])
command = sys.argv[2:]

try:
    process = subprocess.Popen(command, start_new_session=True)
except OSError as exc:
    print(f"Failed to start command: {exc}", file=sys.stderr)
    sys.exit(127)

try:
    sys.exit(process.wait(timeout=seconds))
except subprocess.TimeoutExpired:
    print(f"Command timed out after {seconds:g}s.", file=sys.stderr)
    try:
        os.killpg(process.pid, signal.SIGTERM)
    except ProcessLookupError:
        pass
    try:
        process.wait(timeout=5)
    except subprocess.TimeoutExpired:
        try:
            os.killpg(process.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
        process.wait()
    time.sleep(0.1)
    sys.exit(124)
PY
}
