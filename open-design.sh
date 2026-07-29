#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default configuration values
TARGET_DIR="${TARGET_DIR:-"./build/open-design"}"
SOURCE_DIR="${SOURCE_DIR:-"$HOME/.od"}"
EXPORT_PATH="${EXPORT_PATH:-"./open-design-sessions.tar.gz"}"

usage() {
    cat <<EOF
Usage: $(basename "$0") [COMMAND] [OPTIONS]

Commands:
  check-prereqs Check if all required prerequisites are installed
  clone       Clone the open-design repository into TARGET_DIR
  build       Build open-design at TARGET_DIR
  run         Run open-design at TARGET_DIR
  export      Export session data from local instance to EXPORT_PATH
  import      Import session data from EXPORT_PATH to TARGET_DIR
  all         Clone, build, export local sessions, and import into target instance

Options:
  -t, --target-dir <path>   Directory where open-design is cloned/built (default: $TARGET_DIR)
  -s, --source-dir <path>   Local open-design source directory for export (default: $SOURCE_DIR)
  -e, --export-path <path>  File path for session export archive (default: $EXPORT_PATH)
  -h, --help                Show this help message
EOF
    exit 0
}

# Parse command line options
COMMAND=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        check|check-prereqs|clone|build|run|export|import|all)
            COMMAND="$1"
            shift
            ;;
        -t|--target-dir)
            TARGET_DIR="$2"
            shift 2
            ;;
        -s|--source-dir)
            SOURCE_DIR="$2"
            shift 2
            ;;
        -e|--export-path)
            EXPORT_PATH="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Error: Unknown option or argument '$1'" >&2
            usage
            ;;
    esac
done

if [ -z "$COMMAND" ]; then
    echo "Error: No command specified." >&2
    usage
fi

# Ensure task runner is installed
if ! command -v task &>/dev/null; then
    echo "Error: 'task' (go-task) is not installed or not in PATH." >&2
    exit 1
fi

export TARGET_DIR
export SOURCE_DIR
export EXPORT_PATH

run_task() {
    local cmd="$1"
    task --taskfile "$SCRIPT_DIR/Taskfile.yml" "$cmd" \
        TARGET_DIR="$TARGET_DIR" \
        SOURCE_DIR="$SOURCE_DIR" \
        EXPORT_PATH="$EXPORT_PATH"
}

case "$COMMAND" in
    check|check-prereqs)
        run_task check-prereqs
        ;;
    clone)
        run_task clone
        ;;
    build)
        run_task build
        ;;
    run)
        run_task run
        ;;
    export)
        run_task export
        ;;
    import)
        run_task import
        ;;
    all)
        echo "Executing full setup: clone -> build -> export -> import..."
        run_task clone
        run_task build
        run_task export
        run_task import
        echo "Setup complete! Run './open-design.sh run' to launch open-design."
        ;;
esac
