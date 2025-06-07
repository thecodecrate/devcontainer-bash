#!/usr/bin/env zsh
#
# Post-creation setup for dev container: step 1/3
#

# Globals
SETUP_DIR="${WORKSPACE_DIR}/.devcontainer/tools"
readonly SETUP_DIR

# Configure faster apt sources (Azure/Microsoft mirrors)
sudo "${SETUP_DIR}/switch-apt-mirror/setup.bash" \
  "http://azure.archive.ubuntu.com/ubuntu/"

# Configure alias files loading
"${SETUP_DIR}/install-custom-config/setup.zsh" \
  --custom-dir "${WORKSPACE_DIR}/.devcontainer/config/aliases"

# Configure config files loading
"${SETUP_DIR}/install-custom-config/setup.zsh" \
  --custom-dir "${WORKSPACE_DIR}/.devcontainer/config/custom"

# Enable git dirty state indicator in prompt
git config --global devcontainers-theme.show-dirty 1

# Shell Linter, Formatter
sudo apt install -y shellcheck shfmt

exit 0
