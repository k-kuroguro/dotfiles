#!/bin/bash

set -euo pipefail

install() {
   bash scripts/aqua-installer.sh install
   bash scripts/rust-installer.sh install
   bash scripts/tmux-installer.sh install
   bash scripts/deno-installer.sh install

   deno run -A --no-lock dotfiles.ts deploy

   ${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin/aqua i -a

   echo "All installations are complete."
}

uninstall() {
   deno run -A --no-lock dotfiles.ts undeploy

   bash scripts/deno-installer.sh uninstall
   bash scripts/tmux-installer.sh uninstall
   bash scripts/rust-installer.sh uninstall
   bash scripts/aqua-installer.sh uninstall

   echo "All uninstallations are complete."
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
