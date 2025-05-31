# devcontainer-bash

> Professional Bash development environment with VS Code devcontainer, BATS testing, debugging, and AI integration

## 🚧 Work in Progress

This project is currently under active development. The initial implementation is being built on the `initial-implementation` branch.

## Overview

A comprehensive VS Code development container template designed for professional bash script development. This template provides a complete development environment with modern tooling, testing frameworks, debugging capabilities, and AI-enhanced development workflows.

### Key Features (Planned)

- **🐳 Development Container**: Ubuntu-based devcontainer with Zsh shell
- **🧪 Testing Framework**: BATS-Core with assertion and support helpers
- **🐛 Debugging Support**: BashDB integration with VS Code debugging interface
- **✅ Code Quality**: ShellCheck linting and shfmt formatting
- **🤖 AI Integration**: GitHub Copilot with custom instructions and MCP servers
- **📁 Project Structure**: Organized file layout for scalable bash projects
- **⚡ Developer Experience**: Custom aliases, themes, and VS Code task integration

## Planned Architecture

```
/
├── src/                    # Source bash scripts
├── test/                   # BATS test files and framework
│   ├── *.bats             # Test implementations
│   ├── bats/              # BATS core (submodule)
│   └── test_helper/       # Helper libraries (submodules)
├── .devcontainer/         # Container configuration
│   ├── scripts/           # Lifecycle automation
│   └── etc/bash-aliases   # Alias management
├── .vscode/               # IDE configuration
└── .github/               # AI instructions and metadata
```

## Development Status

- [x] Project specification complete
- [ ] Development container configuration
- [ ] BATS testing framework integration
- [ ] BashDB debugging setup
- [ ] Code quality toolchain (ShellCheck + shfmt)
- [ ] VS Code task configuration
- [ ] AI integration (Copilot + MCP servers)
- [ ] Documentation and examples
- [ ] Template validation and testing

## Template Collection

This repository is part of a larger collection of development container templates maintained by [thecodecrate](https://github.com/thecodecrate). Each template provides a specialized development environment for different languages and frameworks:

- `devcontainer-bash` (this repository)
- `devcontainer-laravel` (planned)
- `devcontainer-nextjs` (planned)
- `devcontainer-expo` (planned)
- `devcontainer-nestjs` (planned)

## Getting Started

⚠️ **Not yet available** - This template is still in development.

Once complete, you'll be able to:

1. Use this template to create a new repository
2. Open in VS Code with Dev Containers extension
3. Start developing bash scripts with full toolchain support

## Contributing

This project is currently in initial development phase. Contributions will be welcomed once the first version is complete.

## License

[MIT License](LICENSE) - Use this template freely for your projects.

---

**Status**: 🚧 In Development | **Target**: Professional Bash Development Environment | **Maintainer**: [@thecodecrate](https://github.com/thecodecrate)
