#!/usr/bin/env zsh
#
# Post-creation setup for dev container: step 1/3
#

# Globals
SETUP_DIR="${WORKSPACE_DIR}/.devcontainer/tools"
readonly SETUP_DIR

# Install tools for dev container setup
SHARED_BIN_DIR="/usr/local/bin"
sudo "${SETUP_DIR}/switch-apt-mirror/install.zsh" --prefix "${SHARED_BIN_DIR}" --create-dirs
sudo "${SETUP_DIR}/enable-config-dir/install.zsh" --prefix "${SHARED_BIN_DIR}" --create-dirs
sudo "${SETUP_DIR}/setup-omz-plugins/install.zsh" --prefix "${SHARED_BIN_DIR}" --create-dirs

# Configure faster apt sources (Azure/Microsoft mirrors)
sudo switch-apt-mirror "http://azure.archive.ubuntu.com/ubuntu/"

# Configure alias files loading
enable-config-dir "${WORKSPACE_DIR}/.devcontainer/config/aliases"

# Configure config files loading
enable-config-dir "${WORKSPACE_DIR}/.devcontainer/config/custom"

# ohmyzsh plugins from GitHub
setup-omz-plugins \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-history-substring-search

# Enable git dirty state indicator in prompt
git config --global devcontainers-theme.show-dirty 1

# Shell Linter, Formatter
sudo apt install -y shellcheck shfmt

exit 0
