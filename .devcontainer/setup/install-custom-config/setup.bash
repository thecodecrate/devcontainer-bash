#!/usr/bin/env bash
#
# Sets up a custom configuration loader for oh-my-zsh that automatically
# sources shell scripts from a specified directory on every new shell session.
# This provides the same effect as sourcing scripts directly in ~/.zshrc but
# allows for easier management of custom configurations.
#
# Usage:
#   ./setup.bash --custom-dir <path>
#
# Notes:
# - Requires oh-my-zsh and $ZSH_CUSTOM environment variable
# - Generated loader persists across shell sessions
# - Uses MD5 hash of directory path to prevent duplicate loaders
# - Re-running for same directory overwrites existing loader safely

set -euo pipefail

# Global variables
SELF_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
readonly SELF_DIR

ZSH_CUSTOM=$(zsh -ic "echo \$ZSH_CUSTOM")
readonly ZSH_CUSTOM

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
  log::info "About to install loader on ${ZSH_CUSTOM} with args:\n" \
    "$*"
}

check_dependencies() {
  if ! command -v envsubst > /dev/null 2>&1; then
    log::error "envsubst is required to generate the loader script."
    exit 1
  fi

  if ! command -v md5sum > /dev/null 2>&1; then
    log::error "md5sum is required to generate the loader filename."
    exit 1
  fi

  if [[ -z "${ZSH_CUSTOM:-}" ]]; then
    log::error "ZSH_CUSTOM environment variable is not set. Please ensure oh-my-zsh is installed."
    exit 1
  fi

  if [[ ! -d "${ZSH_CUSTOM}" ]]; then
    log::error "ZSH_CUSTOM directory does not exist: ${ZSH_CUSTOM}"
    exit 1
  fi
}

parse_args() {
  local custom_dir=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --custom-dir)
        custom_dir="$2"
        shift 2
        ;;
      -*)
        log::error "Unknown option: $1"
        exit 1
        ;;
      *)
        log::error "Unexpected argument: $1"
        exit 1
        ;;
    esac
  done

  if [[ -z "${custom_dir}" ]]; then
    log::error "--custom-dir is required."
    exit 1
  fi

  echo "${custom_dir}"
}

loader::_generate_filename() {
  local custom_dir="$1"

  # Use md5sum to hash the custom_dir path and extract the last 12 chars
  local hash
  hash=$(echo -n "$custom_dir" | md5sum | awk '{print $1}' | tail -c 10)

  echo "custom-config-loader_${hash}.zsh"
}

loader::install() {
  local custom_dir="$1"
  custom_dir=$(realpath "$custom_dir")

  local loader_filename
  loader_filename=$(loader::_generate_filename "$custom_dir")

  # Template variables
  export CUSTOM_DIR="${custom_dir}"

  # shellcheck disable=SC2016
  envsubst \
    '${CUSTOM_DIR}' \
    < "${SELF_DIR}/loader.zsh.template" \
    > "${ZSH_CUSTOM}/${loader_filename}"

  # Return
  echo "${ZSH_CUSTOM}/${loader_filename}"
}

main() {
  show_environment "$@"

  check_dependencies

  local custom_dir
  custom_dir=$(parse_args "$@")

  local result
  result=$(loader::install "${custom_dir}")

  log::success "Custom config loader installed: ${result}"
}

main "$@"
