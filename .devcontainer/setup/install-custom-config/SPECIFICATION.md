# install-custom-config Tool Specification

## Overview

An oh-my-zsh utility that integrates custom configuration loading into any oh-my-zsh installation. The tool creates an autoloader that sources custom shell scripts from a user-specified directory, leveraging oh-my-zsh's automatic `.zsh` file sourcing mechanism.

## Requirements

### Functional Requirements

**Primary Function**: Install a custom configuration autoloader into oh-my-zsh's custom directory that automatically sources shell scripts from a user-specified directory.

**Target Environment**:

- oh-my-zsh installation
- zsh shell environment only

**Processing Scope**: User-initiated setup tool for configuring custom script loading.

### Command Line Interface

```bash
./setup.zsh --custom-dir <path>
```

**Parameters**:

- `--custom-dir <path>`: Required. Directory path containing custom shell scripts to be auto-loaded

### Dependencies

**Required Environment Variables**:

- `$ZSH_CUSTOM`: oh-my-zsh custom directory (set by oh-my-zsh)

**Prerequisites**:

- oh-my-zsh must be installed and configured
- `envsubst` utility available for template processing

### File Structure

**Source Files**:

- `setup.zsh`: Main installation script
- `loader.zsh.template`: Template for the autoloader script

**Generated Output**:

- `${ZSH_CUSTOM}/custom-config-loader_${hash}.zsh`: Final autoloader script with directory-specific naming

**Target Directory**:

- User-specified directory containing custom scripts

### Template Processing

**Template Variables**:

- `${CUSTOM_DIR}`: User-provided directory path from --custom-dir argument

**Processing Method**: Use `envsubst` to substitute template variables in `loader.zsh.template`.

### Filename Generation

**Algorithm**: Generate MD5 hash of the absolute path (via `realpath`) of the custom directory.

**Hash Truncation**: Use the last 9 characters of the MD5 hash for the filename suffix.

**Collision Resistance**: 36^9 possible combinations provide sufficient uniqueness for typical use cases.

**Deterministic**: Same directory path always generates the same loader filename, enabling safe re-installation.

## Implementation Architecture

### Core Script: `setup.zsh`

**Purpose**: Generate and install the autoloader script into oh-my-zsh's custom directory.

**Key Operations**:

1. Validate command line arguments
2. Generate directory-specific loader filename using MD5 hash of absolute path
3. Set template variable `CUSTOM_DIR` from --custom-dir argument
4. Process template file with `envsubst`
5. Output result to `${ZSH_CUSTOM}/custom-config-loader_${hash}.zsh`

**Execution Context**: Direct execution by user.

### Autoloader: `custom-config-loader.zsh`

**Purpose**: Automatically source custom shell scripts when zsh starts.

**Core Function**: `load_custom_dir()`

**Processing Logic**:

- Check if target directory exists and is readable
- Find all `.sh`, `.zsh`, and `.bash` files in the directory
- Source each readable file
- Handle missing directories gracefully (no errors)

**Integration**: Leverages oh-my-zsh's automatic sourcing of `.zsh` files in `$ZSH_CUSTOM`.

### File Discovery Pattern

**Supported Extensions**: `.sh`, `.zsh`, `.bash`

**Search Pattern**: `"${custom_dir}/"*.{sh,zsh,bash}`

**Safety Checks**:

- Verify directory exists before processing
- Check file existence and readability before sourcing
- Use `null_glob` option to handle empty matches

## Error Handling

**Argument Validation**:

- Require --custom-dir option with directory path
- Display usage message for missing or incorrect arguments

**Directory Validation**:

- Skip processing if `CUSTOM_DIR` is empty or undefined
- Skip processing if target directory doesn't exist
- No error messages for missing directories (silent failure)

**File Processing**:

- Skip files that don't exist or aren't readable
- Continue processing remaining files if one file fails

**Template Processing**:

- Script assumes `envsubst` and template file are available
- No explicit error handling for missing dependencies

## Integration Details

### oh-my-zsh Integration

**Mechanism**: oh-my-zsh automatically sources all `.zsh` files in `$ZSH_CUSTOM` directory during shell initialization.

**Naming Strategy**: Files named `custom-config-loader_${hash}.zsh` where hash is the last 9 characters of the MD5 checksum of the absolute directory path.

**Duplicate Prevention**: Multiple installations for the same directory will overwrite the existing loader, preventing duplicate script execution.

**Multiple Directories**: Each unique directory gets its own loader file, enabling support for multiple custom configuration sources.

**Load Order**: Depends on oh-my-zsh's file discovery order (typically alphabetical).

### Installation Workflow

**Installation Phase**: User runs setup script with desired directory path.

**Runtime Phase**: Autoloader executes on every new zsh shell session.

**Persistence**: Generated autoloader persists until manually removed.

## Usage Context

**Execution Method**:

```bash
./setup.zsh --custom-dir /path/to/custom/scripts
```

**Typical Use Cases**:

- Personal dotfiles organization
- Project-specific shell configurations
- Devcontainer custom script loading
- Team shared configuration management

**User Interaction**: Single command execution with directory argument.

## Implementation Notes

**Shell Compatibility**: zsh-specific implementation using oh-my-zsh infrastructure.

**Template Strategy**: Use external template file for maintainability and clear separation of concerns.

**Directory Flexibility**: Accepts any valid directory path from user.

**Safety**: Silent failure approach for missing directories to avoid disrupting shell startup.

## Post-Implementation

**User Workflow**:

1. Run setup script with desired custom directory path
2. Add custom shell scripts to specified directory
3. Start new zsh session (scripts automatically loaded)
4. No additional configuration required

**File Management**:

- Users can add/remove files in custom directory
- Changes take effect on next shell session
- Directory can be created after loader installation
- No need to re-run setup for file changes
