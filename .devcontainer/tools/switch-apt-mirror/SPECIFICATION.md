# switch-apt-mirror Tool Specification

## Overview

A bash utility for safely switching APT repository mirrors in Debian-based systems. The tool replaces repository URLs while preserving all other source configuration details and providing automatic backup functionality.

## Requirements

### Functional Requirements

**Primary Function**: Replace the URI component of APT source entries while maintaining all other repository metadata (type, options, distribution, suite, components).

**Target Files**:

- `/etc/apt/sources.list` only

**Processing Scope**: Handle only active (uncommented) repository entries.

### Command Line Interface

```bash
switch-apt-mirror [OPTIONS] <new_mirror>
```

**Parameters**:

- `<new_mirror>`: Required. The new repository mirror URL (e.g., `mirrors.kernel.org`)

**Options**:

- `--type [deb|deb-src|all]`: Filter by repository type (default: `all`)
- `--suite [updates|backports|security|main|all]`: Filter by distribution suite (default: `all`)
- `--no-backup`: Skip backup creation

### Repository Entry Format

APT source entries follow this structure:

```text
<type> [<options>] <uri> <distribution>[-<suite>] <component1> [component2] ...
```

**Field Definitions**:

- `<type>`: `deb` (binary packages) or `deb-src` (source packages)
- `[<options>]`: Optional parameters in square brackets (e.g., `[arch=amd64 signed-by=/path/to/key]`)
- `<uri>`: Repository URL (the field this tool modifies)
- `<distribution>`: Distribution codename (e.g., `focal`, `jammy`)
- `<suite>`: Optional suite suffix (`-updates`, `-backports`, `-security`)
- `<component>`: Repository components (`main`, `universe`, `restricted`, `multiverse`)

### Filtering Logic

**Type Filtering**:

- `deb`: Match only binary package repositories
- `deb-src`: Match only source package repositories
- `all`: Match both types

**Suite Filtering**:

- `updates`: Match distributions ending with `-updates`
- `backports`: Match distributions ending with `-backports`
- `security`: Match distributions ending with `-security`
- `main`: Match distributions without suite suffix (base distribution)
- `all`: Match any distribution/suite combination

### Backup System

**Default Behavior**: Create timestamped backups before any modifications.

**Backup Location**: `/etc/apt/sources.list.backup.YYYYMMDD_HHMMSS`

**Convenience Symlink**: `/etc/apt/sources.list.backup` → most recent backup

**Skip Option**: Use `--no-backup` to disable backup creation.

## Implementation Architecture

### Core Function: `replace_entry_uri`

**Purpose**: Central processing function for URI replacement in source entries.

**Parameters**:

- `$type`: Type filter value
- `$suite`: Suite filter value
- `$new_mirror`: Replacement mirror URL

**Processing Engine**: AWK-based text processing for reliable field parsing.

**Key Capabilities**:

- Parse complex APT source format with optional `[options]` blocks
- Handle wildcard matching for type and suite filters
- Process only active (uncommented) repository entries
- Preserve exact formatting and spacing of non-URI fields

### AWK Processing Logic

**Field Identification**:

- Detect presence of optional `[options]` block
- Correctly identify URI field position (field 2 or 3 depending on options)
- Preserve all other fields unchanged

**Pattern Matching**:

- Type matching: exact match or wildcard (`all`)
- Suite extraction: parse distribution field for suite suffix
- Suite matching: exact match, `main` (no suffix), or wildcard (`all`)

**Output Generation**:

- Reconstruct source entry with new mirror URL
- Maintain original field spacing and formatting
- Skip commented/disabled repositories (leave unchanged)

### Error Handling

**Prerequisites**:

- Verify root/sudo privileges for `/etc/apt/` modifications
- Check file existence and permissions
- Validate new mirror URL format

**Input Validation**:

- Accept any string values for `--type` and `--suite` options (no hardcoded validation)
- Allow flexibility for custom repository types and suites beyond standard values
- Only validate that required parameters are provided

**Backup Failures**:

- Abort operation if backup creation fails (unless `--no-backup`)
- Provide clear error messages for permission issues

**Processing Errors**:

- Handle malformed source entries gracefully
- Report files that couldn't be processed
- Ensure atomic operations (backup → modify → verify)

## Usage Examples

**Basic mirror change**:

```bash
sudo switch-apt-mirror mirrors.kernel.org
```

**Target only binary packages**:

```bash
sudo switch-apt-mirror --type deb mirrors.kernel.org
```

**Update only security repositories**:

```bash
sudo switch-apt-mirror --suite security security.ubuntu.com
```

**Skip backup for testing**:

```bash
sudo switch-apt-mirror --no-backup test-mirror.example.com
```

## Implementation Notes

**Text Processing**: Use AWK for robust field parsing rather than simple string replacement to handle the complex APT source format correctly.

**Compatibility**: Ensure compatibility across Debian-based distributions (Ubuntu, Debian, derivatives).

**Safety**: Implement backup-first approach with verification steps to prevent system breakage.

**Performance**: Process files efficiently, handling both small and large source configurations.

## Post-Implementation

**Manual Steps Required**:

- User must run `sudo apt update` after mirror switching to refresh package lists
- Recommend testing with `apt list --upgradable` to verify mirror connectivity

**Operational Notes**:

- Script creates backup but does not automatically update package cache
- New mirror should be tested before running package operations
- Backup restoration available if mirror proves problematic
