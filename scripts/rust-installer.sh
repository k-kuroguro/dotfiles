#!/bin/bash

# Install or uninstall rustup.

set -euo pipefail

install() {
   if command -v rustup &>/dev/null; then
      echo "rustup is already installed."
      exit 0
   fi

   echo "Installing rustup..."

   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

   echo "rustup installed."
}

uninstall() {
   if command -v rustup &>/dev/null; then
      rustup self uninstall -y
      echo "rustup uninstalled."
   else
      echo "rustup is not installed."
   fi
}

usage() {
  echo "Usage: $0 {install|uninstall}" >&2
  exit 1
}

main() {
   local subcommand="${1:-}"
   case "${subcommand}" in
      install) install ;;
      uninstall) uninstall ;;
      *) usage ;;
   esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
   main "$@"
fi
