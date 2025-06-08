#!/usr/bin/env zsh
#
# Post-creation setup for dev container: step 3/3
#

# Source rc for `omz` command
# shellcheck source=/dev/null
source "${HOME}/.zshrc"

# Enable OMZ plugins
omz plugin enable git
omz plugin enable docker
omz plugin enable docker-compose
omz plugin enable dotenv

exit 0
