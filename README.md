# open-design-script

Automation script and Taskfile for cloning, building, running, exporting, and importing sessions for the [open-design](https://github.com/nexu-io/open-design) project.

## Prerequisites

- **Git**
- **Node.js** (v24 recommended)
- **pnpm** (>= 10)
- **task** ([go-task](https://taskfile.dev/))
- **tar**

To check if all required tools are available in your environment:

```bash
task check-prereqs
# or
./open-design.sh check-prereqs
```

## Nominal Usage

A helper bash script (`open-design.sh`) is provided to streamline common operations:

### 1. Full Setup (Clone, Build, Export, Import)

To execute the entire setup pipeline automatically:

```bash
./open-design.sh all
```

### 2. Individual Commands

#### Clone Open Design
Clone the repository into the target directory (default: `./build/open-design`):

```bash
./open-design.sh clone
```

#### Build
Install dependencies and trigger required workspace/Electron builds:

```bash
./open-design.sh build
```

#### Export Local Sessions
Export session data (`.od` directory) from a local instance to an export archive (`open-design-sessions.tar.gz`):

```bash
./open-design.sh export
```

#### Import Sessions
Import session data into the target instance:

```bash
./open-design.sh import
```

#### Run Open Design
Start open-design inside the target directory:

```bash
./open-design.sh run
```

---

## Options

Customize directory paths using CLI flags:

| Option | Flag | Description | Default |
| --- | --- | --- | --- |
| Target Directory | `-t, --target-dir` | Directory where `open-design` is cloned and built | `./build/open-design` |
| Local Source Directory | `-s, --source-dir` | Local open-design directory for exporting sessions | `$HOME/.od` |
| Export Archive Path | `-e, --export-path` | Archive output file path | `./open-design-sessions.tar.gz` |

### Custom Examples

```bash
# Clone and build in a custom directory
./open-design.sh clone -t /path/to/custom-od
./open-design.sh build -t /path/to/custom-od

# Export sessions from a custom location and import into custom target
./open-design.sh export -s /path/to/local/.od -e ./my-sessions.tar.gz
./open-design.sh import -t /path/to/custom-od -e ./my-sessions.tar.gz

# Run custom target
./open-design.sh run -t /path/to/custom-od
```

---

## Direct `task` Usage

You can also call `task` commands directly:

```bash
task clone TARGET_DIR=./build/open-design
task build TARGET_DIR=./build/open-design
task export SOURCE_DIR=~/.od EXPORT_PATH=./open-design-sessions.tar.gz
task import TARGET_DIR=./build/open-design EXPORT_PATH=./open-design-sessions.tar.gz
task run TARGET_DIR=./build/open-design
```
