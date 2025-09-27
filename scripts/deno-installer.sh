#!/bin/bash

# Install or uninstall deno.

set -euo pipefail

install() {
   if command -v deno &>/dev/null; then
      echo 'deno is already installed.'
      exit 0
   fi

   echo 'Installing deno...'

   curl -fsSL https://deno.land/x/install/install.sh | sh -s -- -y --no-modify-path

   echo 'deno installed.'
}

uninstall() {
   if command -v deno &>/dev/null; then
      rm -r ~/.deno
      echo 'deno uninstalled.'
   else
      echo 'deno is not installed.'
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
