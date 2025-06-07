#!/usr/bin/env zsh
#
# Post-creation setup for dev container: step 3/3
#

# Globals
SETUP_DIR="${WORKSPACE_DIR}/.devcontainer/tools"
readonly SETUP_DIR

# Source rc for `omz` command
# shellcheck source=/dev/null
source "${HOME}/.zshrc"

# Install OMZ plugins from github
"${SETUP_DIR}/install-omz-plugins/setup.zsh" \
  "zsh-users/zsh-autosuggestions" \
  "zsh-users/zsh-syntax-highlighting" \
  "zsh-users/zsh-completions"

# Enable OMZ plugins
omz plugin enable zsh-autosuggestions
omz plugin enable zsh-syntax-highlighting
omz plugin enable zsh-completions

# Enable core plugins
omz plugin enable git
omz plugin enable docker
omz plugin enable docker-compose
omz plugin enable dotenv

exit 0
