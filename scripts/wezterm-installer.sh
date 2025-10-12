#!/bin/bash

# Install or uninstall wezterm AppImage.
#
# Downloads the latest wezterm AppImage from https://github.com/wezterm/wezterm and installs it to ~/.local/bin/wezterm.
# Provides two subcommands:
#   install   - Download and install the AppImage
#   uninstall - Remove ~/.local/bin/wezterm

set -euo pipefail

readonly WEZTERM_BIN="${HOME}/.local/bin/wezterm"

install() {
   local existing_wezterm
   existing_wezterm="$(command -v wezterm || true)"

   if [[ -n "${existing_wezterm}" ]]; then
      if [[ "${existing_wezterm}" == "${WEZTERM_BIN}" ]]; then
         echo "wezterm is already installed at ${WEZTERM_BIN}."
         exit 0
      fi
      echo "Warning: wezterm is already installed at ${existing_wezterm}. (will install to ${WEZTERM_BIN} as well)" >&2
   fi

   echo 'Installing wezterm AppImage...'
   curl -sL https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/WezTerm-20240203-110809-5046fc22-Ubuntu20.04.AppImage -o wezterm.appimage

   chmod +x wezterm.appimage
   mkdir -p "$(dirname "${WEZTERM_BIN}")"
   mv wezterm.appimage "${WEZTERM_BIN}"

   echo "wezterm installed to ${WEZTERM_BIN}."
}

uninstall() {
   if [[ -f "${WEZTERM_BIN}" ]]; then
      rm "${WEZTERM_BIN}"
      echo "wezterm uninstalled from ${WEZTERM_BIN}."
   else
      echo "wezterm is not installed in ${WEZTERM_BIN}."
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
