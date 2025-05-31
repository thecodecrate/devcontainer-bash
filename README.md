# Bash Development Template

> Professional bash development environment with VS Code devcontainer, BATS testing, debugging, and AI integration

## ✨ Features

A comprehensive VS Code development container template designed for professional bash script development. This template provides a complete development environment with modern tooling, testing frameworks, debugging capabilities, and AI-enhanced workflows.

### 🛠️ Complete Toolchain

- **🐳 Development Container**: Ubuntu-based devcontainer with Zsh shell and custom setup tools
- **🧪 Testing Framework**: BATS-Core with assertion and support helper libraries
- **🐛 Debugging Support**: BashDB integration with VS Code debugging interface
- **✅ Code Quality**: ShellCheck linting and shfmt formatting with real-time feedback
- **🤖 AI Integration**: GitHub Copilot with custom instructions and MCP servers
- **📁 Project Structure**: Organized file layout for scalable bash projects
- **⚡ Developer Experience**: Custom aliases, themes, and VS Code task integration
- **🔧 Setup Automation**: Custom devcontainer tools for zsh plugins and configuration management

## 🏗️ Architecture

```bash
/
├── src/                         # Source bash scripts
├── test/                        # BATS test files and framework
│   ├── *.bats                  # Test implementations
│   ├── bats/                   # BATS core (submodule)
│   └── test_helper/            # Helper libraries (submodules)
├── .devcontainer/              # Container configuration
│   ├── devcontainer.json       # Main container config
│   ├── setup/                  # Custom setup tools
│   │   ├── install-zsh-plugins/    # Zinit plugin installer
│   │   ├── install-custom-config/  # Oh-my-zsh config loader
│   │   └── switch-apt-mirror/      # APT mirror switcher
│   └── etc/                    # Environment configurations
├── .vscode/                    # IDE configuration
│   ├── tasks.json              # Build and test tasks
│   ├── launch.json             # Debug configurations
│   └── settings.json           # Editor settings
├── .github/                    # AI instructions and metadata
└── docs/                       # Documentation and guidelines
```

## 🚀 Quick Start

### Prerequisites

- [VS Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker](https://www.docker.com/get-started) installed and running

### Getting Started

1. **Use this template** to create a new repository or clone directly:

   ```bash
   git clone https://github.com/thecodecrate/devcontainer-bash.git my-bash-project
   cd my-bash-project
   ```

2. **Open in VS Code**:

   ```bash
   code .
   ```

3. **Reopen in Container** when prompted, or use Command Palette:
   - `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"

4. **Start developing**! The environment includes:
   - Example script: `src/example.sh`
   - Example test: `test/example.bats`
   - Pre-configured tasks and debugging

### First Steps

Run the example test to verify everything works:

```bash
# Using VS Code task (Ctrl+Shift+P → "Tasks: Run Task" → "Test (Bats)")
./test/bats/bin/bats test/

# Or run specific test file
./test/bats/bin/bats test/example.bats
```

Debug the example script:

- Open `src/example.sh`
- Set a breakpoint (click left margin)
- Press `F5` or use "Run and Debug" panel

## 📚 Development Workflow

### Writing Scripts

1. **Create scripts** in `src/` directory following the [shell style guide](docs/guidelines/shell-style.md)
2. **Add tests** in `test/` directory using BATS syntax
3. **Use VS Code features**:
   - IntelliSense for bash commands and variables
   - Real-time ShellCheck linting
   - Format on save with shfmt

### Testing

- **Run all tests**: Use "Test (Bats)" task or `./test/bats/bin/bats test/`
- **Run specific test**: `./test/bats/bin/bats test/my_test.bats`
- **Watch mode**: Not built-in, but easy to add with file watchers

### Debugging

- **Interactive debugging**: Set breakpoints and press `F5`
- **Variable inspection**: Use Debug Console and Watch panels
- **Step execution**: Step into, over, and out of functions

### Code Quality

- **Linting**: ShellCheck runs automatically, see Problems panel
- **Formatting**: Format on save enabled, or use `Shift+Alt+F`
- **Custom rules**: Configure in `.vscode/settings.json` or `.shellcheckrc`

## 🔧 Customization

### Adding Zsh Plugins

The template includes a custom tool for installing zsh plugins via zinit:

```json
{
  "containerEnv": {
    "WITH_ZSH_PLUGINS": "zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting"
  }
}
```

### Custom Shell Configuration

Use the `install-custom-config` tool to automatically load custom scripts:

```bash
./.devcontainer/setup/install-custom-config/setup.bash --custom-dir /path/to/custom/scripts
```

### APT Mirror Switching

For faster package installation in certain regions:

```bash
./.devcontainer/setup/switch-apt-mirror/setup.bash mirrors.kernel.org
```

### VS Code Extensions

Add extensions to `.devcontainer/devcontainer.json`:

```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        "your.extension.id"
      ]
    }
  }
}
```

## 📋 Available VS Code Tasks

| Task | Description | Shortcut |
|------|-------------|----------|
| **Test (Bats)** | Run all BATS tests | `Ctrl+Shift+P` → Tasks |
| **Lint Scripts** | Run ShellCheck on all scripts | Available in task menu |
| **Format Scripts** | Format all scripts with shfmt | Available in task menu |

## 🤖 AI Integration

This template includes comprehensive AI assistance:

### GitHub Copilot

- Custom instructions for bash development in `.github/copilot-instructions.md`
- Context-aware suggestions for shell scripting patterns
- Integrated with VS Code for seamless code completion

### Model Context Protocol (MCP) Servers

Pre-configured MCP servers provide enhanced AI capabilities:

- **Brave Search**: Web search for documentation and examples
- **Memory**: Persistent project knowledge and context
- **Git**: Repository operations and version control assistance
- **Filesystem**: Secure file operations with access controls
- **Fetch**: Web content retrieval and markdown conversion

## 📖 Documentation

- **[Shell Style Guide](docs/guidelines/shell-style.md)**: Coding standards and best practices
- **[Commit Style Guide](docs/guidelines/commit-style.md)**: Git commit message conventions
- **[SPECIFICATION.md](SPECIFICATION.md)**: Complete technical specification
- **Tool Specifications**: Detailed docs for each custom devcontainer tool

## 🧰 Included Tools

### Custom Devcontainer Tools

- **[install-zsh-plugins](/.devcontainer/setup/install-zsh-plugins/)**: Automated zinit plugin installation
- **[install-custom-config](/.devcontainer/setup/install-custom-config/)**: Oh-my-zsh configuration loader
- **[switch-apt-mirror](/.devcontainer/setup/switch-apt-mirror/)**: APT repository mirror management

### Development Tools

- **BATS-Core**: Bash testing framework with helpers
- **BashDB**: Interactive bash debugger
- **ShellCheck**: Static analysis and linting
- **shfmt**: Shell script formatting
- **Zinit**: Fast zsh plugin manager

## License

[MIT License](LICENSE) - Use this template freely for your projects.

---

**Status**: 🚧 In Development | **Target**: Professional Bash Development Environment | **Maintainer**: [@thecodecrate](https://github.com/thecodecrate)
