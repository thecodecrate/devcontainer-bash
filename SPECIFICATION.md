# Bash Development Template - Implementation Specification

## Executive Summary

**Project Goal**: Create a comprehensive VS Code devcontainer template for professional bash script development with integrated testing, debugging, linting, formatting, and AI assistance capabilities.

**Target Outcome**: A production-ready development environment that enables rapid bash script creation with modern IDE features, comprehensive quality assurance, and AI-enhanced development workflows.

**Implementation Approach**: Modular devcontainer architecture leveraging Microsoft's Ubuntu base image with carefully integrated toolchain components and VS Code extensions.

## High-Level Architecture

### Core System Components

1. **Development Container Foundation**
   - Ubuntu-based devcontainer with Zsh shell
   - Lifecycle management scripts for setup automation
   - Modular feature integration approach

2. **Bash Development Toolchain**
   - BATS-Core testing framework with helper libraries
   - BashDB debugger with VS Code integration
   - ShellCheck linting and shfmt formatting
   - Bash IDE extension for language server capabilities

3. **Development Environment**
   - Custom alias management system
   - Docker support (both DinD and DooD patterns)
   - Environment variable standardization
   - Theme and UI customizations

4. **AI Integration Layer**
   - GitHub Copilot with custom instructions
   - Model Context Protocol (MCP) servers
   - Context-aware development assistance

### File Organization Structure

```bash
/
├── src/                   # Source bash scripts
├── test/                  # BATS test files and framework
│   ├── *.bats             # Test implementations
│   ├── bats/              # BATS core (submodule)
│   └── test_helper/       # Helper libraries (submodules)
├── .devcontainer/         # Container configuration
│   ├── etc/aliases        # Alias management
│   └── etc/custom         # Custom shell configurations
├── .vscode/               # IDE configuration
└── .github/               # AI instructions and metadata
```

---

## Detailed Technical Requirements

### Component 1: Development Container Configuration

**File**: `.devcontainer/devcontainer.json`

**Requirements**:

- Base image: `mcr.microsoft.com/devcontainers/base:ubuntu`
- Default shell: Zsh with customization support
- Port forwarding: None required for this template
- Volume mounts: Source code and Docker socket access
- Feature integrations: Common utilities and Docker support

**Extension Requirements**:

- `mads-hartmann.bash-ide-vscode` - Primary bash language server
- `rogalmic.bash-debug` - Debugging interface for BashDB
- `jetmartin.bats` - BATS test file syntax highlighting
- `github.copilot` + `github.copilot-chat` - AI assistance
- `chrisdias.promptboost` - Enhanced AI prompting
- `atomiks.moonlight` - Theme
- `pkief.material-icon-theme` - File icons

**Environment Variables**:

- `WORKSPACE_DIR`: Set to workspace root for script compatibility
- `INSIDE_DEVCONTAINER`: Set to "true" for environment detection

### Component 2: BATS Testing Framework

**Installation Method**: Git submodules for version control and reproducibility

**Submodule Requirements**:

```bash
test/bats/           # bats-core main framework
test/test_helper/bats-assert/   # Assertion helpers
test/test_helper/bats-support/  # Support functions
```

**Integration Requirements**:

- VS Code task configuration for test execution
- TAP-compliant output format
- Test discovery and execution automation
- Syntax highlighting via `jetmartin.bats` extension

**File Structure**:

- Test files: `test/*.bats`
- Helper setup: `test/test_helper/` directory
- Individual test naming: `test_<functionality>.bats`

### Component 3: Debugging Infrastructure

**Tool**: BashDB (GDB-like debugger for bash)

**VS Code Integration**:

- Extension: `rogalmic.bash-debug`
- Configuration file: `.vscode/launch.json`
- Debug features: Breakpoints, variable inspection, call stack, step execution

**Launch Configuration Requirements**:

- Default bash script debugging profile
- Environment variable passing
- Working directory configuration
- Args parameter support for script testing

**Expected Capabilities**:

- Visual breakpoint setting in VS Code
- Variable watch windows
- Step-through debugging (step in/over/out)
- Call stack visualization

### Component 4: Code Quality Tools

**Linting**: ShellCheck integration

- Real-time error detection in VS Code
- Static analysis for syntax, semantics, portability
- Configuration via `.shellcheckrc` or VS Code settings
- Integration through bash-ide-vscode extension

**Formatting**: shfmt integration

- Shell script formatting with configurable rules
- EditorConfig integration for project consistency
- Format-on-save capability
- Support for bash, sh, mksh, POSIX dialects
- Configuration: 2-space indentation, 80-character line limit

**IDE Language Server**:

- Extension: `mads-hartmann.bash-ide-vscode`
- Features: IntelliSense, error diagnostics, symbol navigation
- Integration with ShellCheck and shfmt
- Source code analysis and suggestions

### Component 5: Environment Management

**Alias System**:

- Location: `.devcontainer/etc/bash-aliases/`
- Structure: Modular alias files for different categories
- Loading mechanism: Integration with shell initialization
- Extensibility: Easy addition of new alias categories

**Shell Customization**:

- Zsh configuration extensions via `zshrc-extensions.sh`
- Custom prompt configuration
- History management settings
- Completion system enhancements

**Docker Integration**:

- Support for both docker-in-docker and docker-outside-of-docker patterns
- Docker CLI availability within container
- Socket mounting for host Docker daemon access
- Container feature configuration for Docker support

### Component 6: VS Code Task Integration

**File**: `.vscode/tasks.json`

**Required Tasks**:

- **Test Execution**: Run BATS tests with output formatting
- **Linting**: Execute ShellCheck on source files
- **Formatting**: Run shfmt on specified files or directories
- **Script Execution**: Generic bash script runner with debug support

**Task Specifications**:

- Problem matcher integration for error parsing
- Terminal output with proper formatting
- Keyboard shortcuts for common operations
- Group categorization (build, test, debug)

### Component 7: AI Development Integration

**GitHub Copilot Configuration**:

- Custom instructions file: `.github/copilot-instructions.md`
- Workspace-specific context and coding standards
- Task-specific instruction capabilities
- Integration with shell script development patterns

**Model Context Protocol (MCP) Servers**:

- **Brave Search**: Web search integration for documentation lookup
- **Memory**: Persistent knowledge storage for project context
- **Git**: Repository operations and version control assistance
- **Filesystem**: Secure file operations with access controls
- **Fetch**: Web content retrieval and markdown conversion

**Configuration File**: `.vscode/mcp.json`

- Server endpoint definitions
- Authentication and security settings
- Capability restrictions and access controls

### Component 8: Lifecycle Scripts

**Location**: `.devcontainer/scripts/`

**Required Scripts**:

- **Post-create**: Initial environment setup, tool installation
- **Post-start**: Container startup tasks, service initialization
- **Update-content**: Development dependency updates

**Script Requirements**:

- Idempotent execution (safe to run multiple times)
- Error handling and logging
- Progress indication for long-running operations
- Modular function design for maintainability

### Component 9: Quality Assurance Integration

**EditorConfig**: Project-wide formatting consistency

- Shell script indentation (2 spaces)
- Line ending normalization
- Character encoding specification
- File-specific overrides where needed

**ShellCheck Configuration**: `.shellcheckrc`

- Enabled checks and severity levels
- Shell dialect specification
- Exclusions for specific rules where justified
- Integration with VS Code problem reporting

**Git Integration**:

- Pre-commit hook compatibility
- Ignore patterns for generated files
- Submodule update automation
- MCP server integration for AI-assisted Git operations

---

## Implementation Success Criteria

### Functional Requirements

1. **Development Workflow**: Complete script creation → testing → debugging cycle
2. **Quality Assurance**: Automated linting and formatting on save
3. **Testing Integration**: One-click test execution with VS Code tasks
4. **Debugging Capability**: Visual debugging with breakpoints and inspection
5. **AI Assistance**: Context-aware code generation and review capabilities

### Technical Requirements

1. **Container Performance**: Fast startup and responsive development experience
2. **Tool Integration**: Seamless interaction between all development tools
3. **Extensibility**: Easy addition of new tools and customizations
4. **Reliability**: Consistent environment across different host systems
5. **Documentation**: Clear usage instructions and customization guides

### Quality Standards

1. **Code Consistency**: All generated scripts follow established style guide
2. **Error Handling**: Robust error detection and reporting throughout toolchain
3. **User Experience**: Intuitive interface with helpful defaults
4. **Maintainability**: Modular configuration enabling easy updates
5. **Performance**: Minimal resource overhead for development operations

This specification provides comprehensive technical requirements while maintaining implementation flexibility for the AI assistant to determine optimal approaches for each component.
