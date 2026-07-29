# open-design-script

Taskfile configuration for cloning, building, running, exporting, and importing sessions for the [open-design](https://github.com/nexu-io/open-design) project.

## Prerequisites

- **Git**
- **Node.js** (v24 recommended)
- **pnpm** (>= 10)
- **task** ([go-task](https://taskfile.dev/))
- **tar**

Check if required tools are installed:

```bash
task check-prereqs
```

If `pnpm` is missing, you can install it via:

```bash
task install-pnpm
```

---

## Task Commands

### 1. Full Automated Setup Pipeline
Sequentially execute `clone` -> `build` -> `export` -> `import`:

```bash
task all
```

### 2. Check Prerequisites
Verify system prerequisites (`git`, `node`, `pnpm`, `task`, `tar`):

```bash
task check-prereqs
```

### 2. Clone Open Design
Clone the repository into `TARGET_DIR` (default: `./build/open-design`):

```bash
task clone
```

### 3. Build Open Design
Install dependencies and trigger required workspace/Electron builds inside `TARGET_DIR`:

```bash
task build
```

### 4. Export Local Sessions
Export session data (`.od` directory) from a local open-design instance to `EXPORT_PATH` (default: `./open-design-sessions.tar.gz`):

```bash
task export
```

### 5. Import Sessions
Import session data from `EXPORT_PATH` into `TARGET_DIR/.od`:

```bash
task import
```

### 6. Run Open Design
Start open-design inside `TARGET_DIR`:

```bash
task run
```

---

## Configuration Variables

Tasks accept variables to customize directory locations and behavior:

| Variable | Description | Default Value |
| --- | --- | --- |
| `TARGET_DIR` | Directory where open-design is cloned and built | `./build/open-design` |
| `SOURCE_DIR` | Local directory containing `.od` session data for export | `./open-design` (falls back to `$HOME/.od`) |
| `EXPORT_PATH` | File path for the session export archive | `./open-design-sessions.tar.gz` |
| `APP` | Target application for `task run` | `""` (or `"web"` in headless environments) |

### Custom Variable Examples

```bash
# Clone and build in a custom directory
task clone TARGET_DIR=/path/to/custom-od
task build TARGET_DIR=/path/to/custom-od

# Export sessions from a custom source directory and import into custom target
task export SOURCE_DIR=/path/to/source-od EXPORT_PATH=./my-sessions.tar.gz
task import TARGET_DIR=/path/to/custom-od EXPORT_PATH=./my-sessions.tar.gz

# Run target instance
task run TARGET_DIR=/path/to/custom-od
```
