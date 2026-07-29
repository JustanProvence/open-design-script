# Bash Script Documentation (`open-design.sh`)

`open-design.sh` is a CLI helper script that wraps the project's [Taskfile](Taskfile.yml) tasks with standard command-line flags and argument parsing.

## Usage Syntax

```bash
./open-design.sh [COMMAND] [OPTIONS]
```

---

## Commands

| Command | Description |
| --- | --- |
| `check-prereqs` | Check if required prerequisites are installed |
| `install-pnpm` | Install `pnpm` if missing |
| `clone` | Clone the open-design repository into `TARGET_DIR` |
| `build` | Build open-design inside `TARGET_DIR` |
| `export` | Export session data from local instance to `EXPORT_PATH` |
| `import` | Import session data from `EXPORT_PATH` to `TARGET_DIR` |
| `run` | Run open-design inside `TARGET_DIR` |
| `all` | Sequentially execute `clone` -> `build` -> `export` -> `import` |

---

## Options

| Option | Flag | Description | Default |
| --- | --- | --- | --- |
| Target Directory | `-t, --target-dir <path>` | Location where `open-design` is cloned and built | `./build/open-design` |
| Local Source Directory | `-s, --source-dir <path>` | Local open-design source directory for session export | `$HOME/.od` |
| Export Archive Path | `-e, --export-path <path>` | File path for session export archive | `./open-design-sessions.tar.gz` |
| Help | `-h, --help` | Display usage information | |

---

## Examples

### 1. Full Automated Pipeline
Execute clone, build, session export, and session import in a single run:

```bash
./open-design.sh all
```

### 2. Custom Target & Source Locations

```bash
# Clone and build in a custom directory
./open-design.sh clone -t /path/to/custom-od
./open-design.sh build -t /path/to/custom-od

# Export sessions from custom source directory
./open-design.sh export -s /path/to/source/.od -e ./backup.tar.gz

# Import session archive into target directory
./open-design.sh import -t /path/to/custom-od -e ./backup.tar.gz

# Run open-design from target directory
./open-design.sh run -t /path/to/custom-od
```
