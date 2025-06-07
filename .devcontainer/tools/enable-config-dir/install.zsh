#!/usr/bin/env zsh
#
# Installs the enable-config-dir tool by creating a symlink from run.zsh to
# ~/.local/bin/enable-config-dir. This makes the tool available system-wide
# in the user's PATH without requiring manual alias configuration.
#
# Usage:
#   ./install.zsh
#
# Notes:
# - Creates ~/.local/bin directory if it doesn't exist
# - Overwrites existing installation if present
# - Requires ~/.local/bin to be in user's PATH for system-wide access
# - Creates symlink preserving original script location

set -euo pipefail

SELF_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
readonly SELF_DIR

SRC_SCRIPT_NAME="run.zsh"
readonly SRC_SCRIPT_NAME

DEST_SCRIPT_NAME="enable-config-dir"
readonly DEST_SCRIPT_NAME

DEST_DIR="${HOME}/.local/bin"
readonly DEST_DIR

SRC_SCRIPT_PATH="${SELF_DIR}/${SRC_SCRIPT_NAME}"
readonly SRC_SCRIPT_PATH

DEST_SCRIPT_PATH="${DEST_DIR}/${DEST_SCRIPT_NAME}"
readonly DEST_SCRIPT_PATH

main() {
  if [[ ! -f "${SRC_SCRIPT_PATH}" ]]; then
    echo "Error: ${SRC_SCRIPT_PATH} not found in $(pwd)" >&2
    exit 1
  fi

  if [[ ! -d "${DEST_DIR}" ]]; then
    echo "Directory ${DEST_DIR} does not exist. Creating it..."
    mkdir -p "${DEST_DIR}"
  fi

  if [[ -f "${DEST_SCRIPT_PATH}" ]]; then
    echo "Warning: ${DEST_SCRIPT_PATH} already exists. Overwriting it..."
    rm -f "${DEST_SCRIPT_PATH}"
  fi

  ln -s "${SRC_SCRIPT_PATH}" "${DEST_SCRIPT_PATH}"

  chmod +x "${DEST_SCRIPT_PATH}"

  echo "Installed ${DEST_SCRIPT_NAME} to ${DEST_SCRIPT_PATH}"
}

main "$@"
