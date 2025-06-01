#!/usr/bin/env bash
#
# Installs zinit plugin manager and user-specified zsh plugins for devcontainer setup.
# Designed as a companion tool for devcontainer's common-utils feature.
#
# Usage:
#   ./setup.bash <repo/plugin> [<repo/plugin> ...]
#   ./setup.bash zsh-users/zsh-autosuggestions \
#                zsh-users/zsh-syntax-highlighting
#
# Notes:
# - Plugins must be in zinit's <repo/plugin> format (e.g., zsh-users/zsh-autosuggestions)
# - Installs zinit in non-interactive mode if not already present
# - Continues with remaining plugins if individual installations fail
# - Intended for one-time execution during devcontainer creation
#

set -euo pipefail

{ # Colors
  COLOR_RESET=$'\033[0m'
  COLOR_BOLD_RED=$'\033[1;31m'
  COLOR_BOLD_GREEN=$'\033[1;32m'
  COLOR_BOLD_YELLOW=$'\033[1;33m'
  COLOR_BOLD_BLUE=$'\033[1;34m'
}

{ # Logging functions
  log::info() {
    echo -e "${COLOR_BOLD_BLUE}[INFO]${COLOR_RESET} $*" >&2
  }

  log::success() {
    echo -e "${COLOR_BOLD_GREEN}[SUCCESS]${COLOR_RESET} $*" >&2
  }

  log::warning() {
    echo -e "${COLOR_BOLD_YELLOW}[WARNING]${COLOR_RESET} $*" >&2
  }

  log::error() {
    echo -e "${COLOR_BOLD_RED}[ERROR]${COLOR_RESET} $*" >&2
  }
}

show_environment() {
  log::info "About to install zsh plugins with args:\n" \
    "$*"
}

check_dependencies() {
  if ! command -v curl > /dev/null 2>&1 && ! command -v wget > /dev/null 2>&1; then
    log::error "curl or wget is required to install zinit."
    exit 1
  fi

  if ! command -v zsh > /dev/null 2>&1; then
    log::error "zsh is required to install zinit."
    exit 1
  fi
}

parse_args() {
  local -a plugins
  if [[ $# -eq 1 && "$1" == *' '* ]]; then
    # Single argument with spaces: split into array
    read -ra plugins <<< "$1"
  else
    plugins=("$@")
  fi
  echo "${plugins[@]}"
}

zinit::is_installed() {
  zsh -ic "command -v zinit > /dev/null 2>&1"
}

zinit::install() {
  export NO_INPUT=true

  if command -v curl > /dev/null 2>&1; then
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  else
    bash -c "$(wget -qO- https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
  fi
}

plugins::install() {
  local plugins=("$@")

  if [[ ${#plugins[@]} -eq 0 ]]; then
    log::info "No plugins specified for installation."
    return 0
  fi

  for plugin in "${plugins[@]}"; do
    log::info "Installing plugin: $plugin"

    if zsh -ic "zinit light $plugin"; then
      log::success "Installed: $plugin"
    else
      log::warning "Failed to install: $plugin"
    fi
  done
}

main() {
  show_environment "$@"

  check_dependencies

  # Parse plugins into an array
  local -a plugins
  read -ra plugins <<< "$(parse_args "$@")"

  if [[ ${#plugins[@]} -eq 0 ]]; then
    log::success "No plugins specified for installation."
    exit 0
  fi

  if ! zinit::is_installed; then
    zinit::install
  fi

  plugins::install "${plugins[@]}"

  log::success "All specified zsh plugins have been processed."
}

main "$@"
