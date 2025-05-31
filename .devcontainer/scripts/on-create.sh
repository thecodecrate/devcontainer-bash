#!/usr/bin/env bash
#
# Post-creation setup for dev container: step 1/3
#

# Globals
SETUP_DIR="$WORKSPACE_DIR/.devcontainer/setup"

# Configure faster apt sources (Azure/Microsoft mirrors)
sudo "${SETUP_DIR}/switch-apt-mirror/setup.bash" \
  "http://azure.archive.ubuntu.com/ubuntu/"

# Update apt package index
echo "Updating apt package index..."
sudo apt update

# shellcheck disable=SC2086
# Install Oh My Zsh plugins
"${SETUP_DIR}/install-zsh-plugins/setup.bash" \
  $WITH_ZSH_PLUGINS

# Configure alias files loading
"${SETUP_DIR}/install-custom-config/setup.bash" \
  --custom-dir "${WORKSPACE_DIR}/.devcontainer/etc/aliases"

# Configure config files loading
"${SETUP_DIR}/install-custom-config/setup.bash" \
  --custom-dir "${WORKSPACE_DIR}/.devcontainer/etc/custom"

# Enable git dirty state indicator in prompt
git config --global devcontainers-theme.show-dirty 1

# Shell Linter, Formatter
sudo apt install -y shellcheck shfmt

exit 0
