#!/bin/bash

# Install or uninstall aqua.

set -euo pipefail

readonly AQUA_DIR="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}"
readonly AQUA_BIN="${AQUA_DIR}/bin/aqua"

install() {
   local existing_aqua
   existing_aqua="$(command -v aqua || true)"

   if [[ -n "${existing_aqua}" ]]; then
      if [[ "${existing_aqua}" == "${AQUA_BIN}" ]]; then
         echo "aqua is already installed at ${AQUA_BIN}."
         exit 0
      fi
      echo "Warning: aqua is already installed at ${existing_aqua}. (will install to ${AQUA_BIN} as well)" >&2
   fi

   echo 'Installing aqua...'
   curl -sSfL -O https://raw.githubusercontent.com/aquaproj/aqua-installer/v4.0.2/aqua-installer
   echo "98b883756cdd0a6807a8c7623404bfc3bc169275ad9064dc23a6e24ad398f43d  aqua-installer" | sha256sum -c -
   chmod +x aqua-installer
   ./aqua-installer
   rm aqua-installer

   echo "aqua installed to ${AQUA_BIN}."
}

uninstall() {
   if [[ -d "${AQUA_DIR}" ]]; then
      rm -r "${AQUA_DIR}"
      echo "aqua uninstalled from ${AQUA_DIR}."
   else
      echo "aqua is not installed in ${AQUA_DIR}."
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
