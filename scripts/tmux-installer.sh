#!/bin/bash

# Install or uninstall tmux AppImage.
#
# Downloads the latest tmux AppImage from https://github.com/kiyoon/tmux-appimage and installs it to ~/.local/bin/tmux.
# Provides two subcommands:
#   install   - Download and install the AppImage
#   uninstall - Remove ~/.local/bin/tmux

set -euo pipefail

readonly TMUX_BIN="${HOME}/.local/bin/tmux"

install() {
   local existing_tmux
   existing_tmux="$(command -v tmux || true)"

   if [[ -n "${existing_tmux}" ]]; then
      if [[ "${existing_tmux}" == "${TMUX_BIN}" ]]; then
         echo "tmux is already installed at ${TMUX_BIN}."
         exit 0
      fi
      echo "Warning: tmux is already installed at ${existing_tmux}. (will install to ${TMUX_BIN} as well)" >&2
   fi

   echo "Installing tmux AppImage..."
   curl -s https://api.github.com/repos/kiyoon/tmux-appimage/releases/latest \
      | grep "browser_download_url.*appimage" \
      | cut -d : -f 2,3 \
      | tr -d '"' \
      | wget -qi - -O tmux.appimage

   chmod +x tmux.appimage
   mkdir -p "$(dirname "${TMUX_BIN}")"
   mv tmux.appimage "${TMUX_BIN}"

   echo "tmux installed to ${TMUX_BIN}."
}

uninstall() {
   if [[ -f "${TMUX_BIN}" ]]; then
      rm "${TMUX_BIN}"
      echo "tmux uninstalled from ${TMUX_BIN}."
   else
      echo "tmux is not installed in ${TMUX_BIN}."
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
