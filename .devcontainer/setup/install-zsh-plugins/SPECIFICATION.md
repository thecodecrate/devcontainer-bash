# install-zsh-plugins Tool Specification

## Overview

A devcontainer utility that automatically installs zsh plugins via zinit during container creation. The tool integrates with the devcontainer `common-utils` feature to enhance zsh installations with user-specified plugins, designed for one-time execution during devcontainer setup through the `onCreateCommand` lifecycle hook.

## Requirements

### Functional Requirements

**Primary Function**: Install zinit plugin manager and user-specified zsh plugins in a devcontainer environment during container creation.

**Target Environment**:

- Devcontainer with zsh installed (typically via `common-utils` feature)
- Linux-based development containers
- Non-interactive execution context

**Processing Scope**: One-time setup tool for configuring zsh plugin environment.

### Command Line Interface

```bash
./setup.zsh <repo/plugin> [<repo/plugin> ...]
```

**Input Format**:

- Arguments: Space-separated list of zinit-compatible plugin identifiers
- Plugin formats: `<repo/plugin>` (e.g., `zsh-users/zsh-autosuggestions`) or URI

**Examples**:

```bash
./setup.zsh zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting
./setup.zsh romkatv/powerlevel10k agkozak/zsh-z zsh-users/zsh-completions
```

### Dependencies

**Required Environment**:

- zsh shell installed and available
- curl or wget for zinit installation
- Internet connectivity for plugin downloads

**Zinit Installation Requirements**:

- Non-interactive mode support via `NO_INPUT=true` environment variable
- Standard zinit installation script from official repository

### Integration Context

**Devcontainer Integration via onCreateCommand**:

```bash
# In on-create.sh or similar script
/path/to/setup.zsh ${WITH_ZSH_PLUGINS}
```

**Environment Variable Format**:

```json
{
  "containerEnv": {
    "WITH_ZSH_PLUGINS": "zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting"
  }
}
```

**Companion Feature**: Designed to complement the `common-utils` devcontainer feature's zsh installation.

**Execution Timing**: Single execution during devcontainer creation, not on every container start.

## Implementation Architecture

### Core Script: `setup.zsh`

**Purpose**: Orchestrate zinit installation and plugin setup process.

**Key Operations**:

1. Validate command line arguments
2. Install zinit in non-interactive mode
3. Parse plugin arguments from command line
4. Install each specified plugin via zinit
5. Configure zinit for future shell sessions

**Execution Context**: Container creation phase, non-interactive environment.

### Zinit Installation Process

**Installation Method**: Official zinit installation script with non-interactive mode.

**Environment Setup**:

```bash
NO_INPUT=true bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

**Installation Target**: Default zinit directory (`~/.local/share/zinit/zinit.git`)

**Configuration**: Automatic zinit initialization in `~/.zshrc`

### Plugin Installation Loop

**Processing Logic**:

1. Process command line arguments as plugin identifiers
2. For each plugin argument:
   - Execute `zinit light <repo/plugin>` command
   - Handle installation errors gracefully
   - Continue with remaining plugins on individual failures

**Plugin Loading Method**: Use `zinit light` for fast, lightweight plugin loading.

**Installation Persistence**: Plugins are loaded and available in all future zsh sessions.

### Array Processing

**Input Parsing**: Process command line arguments directly as plugin identifiers.

**Plugin Validation**: Accept any zinit-compatible `<repo/plugin>` format or URI without strict validation.

**Error Handling**: Continue processing remaining plugins if individual installations fail.

## Error Handling

**Installation Failures**:

- Continue with remaining plugins if individual installations fail
- Script will fail naturally if critical dependencies are missing
- Devcontainer logs will show any errors during container creation

**User Experience**:

- Minimal output for successful operations
- Clear error messages for failures
- Non-interactive execution

## Plugin Format Support

### Supported Plugin Types

**GitHub Repositories**:

- `<repo/plugin>`: Standard GitHub repository format (e.g., `zsh-users/zsh-autosuggestions`)
- URI format: Full repository URLs

**Zinit Compatibility**: Support any plugin format that zinit accepts natively using the `<repo/plugin>` convention.

### Plugin Examples

```bash
./setup.zsh zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting agkozak/zsh-z
```

## Usage Context

### Devcontainer Configuration

```json
{
  "features": {
    "ghcr.io/devcontainers/features/common-utils:2": {
      "installZsh": true
    }
  },
  "onCreateCommand": "bash -i .devcontainer/setup/install-zsh-plugins/setup.zsh ${WITH_ZSH_PLUGINS}",
  "containerEnv": {
    "WITH_ZSH_PLUGINS": "zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting agkozak/zsh-z"
  }
}
```

### Execution Requirements

**File Permissions**: Ensure script has execute permissions (`chmod +x setup.zsh`).

## Implementation Notes

**Target Shell**: zsh-specific implementation leveraging zinit infrastructure.

**Installation Scope**: User-level installation, no system-wide modifications required.

**Configuration Persistence**: Zinit automatically configures `~/.zshrc` for future sessions.

## Post-Implementation

**User Workflow**:

1. Configure `WITH_ZSH_PLUGINS` in devcontainer.json
2. Add `onCreateCommand` with conditional call to setup script
3. Build/rebuild devcontainer
4. Plugins automatically available in all zsh sessions

**Plugin Management**: Modify `WITH_ZSH_PLUGINS` and rebuild container for changes.
