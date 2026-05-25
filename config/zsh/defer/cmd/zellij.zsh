export ZELLIJ_PLUGINS_DIR="${XDG_DATA_HOME}/zellij/plugins"

mkdir -p "${ZELLIJ_PLUGINS_DIR}"

__ensure_plugin() {
   local url="$1"
   local filename="${2:-$(basename "${url}")}"

   local dir="${ZELLIJ_PLUGINS_DIR}"
   local filepath="${dir}/${filename}"

   if [[ ! -r "${filepath}" ]]; then
      local tmpfile
      tmpfile="$(mktemp "${dir}/${filename}.XXXXXX")" || return 1

      if ! curl -fsSL "${url}" -o "${tmpfile}"; then
         echo "Failed to download plugin from ${url}." >&2
         rm -f "${tmpfile}"
         return 1
      fi

      mv "${tmpfile}" "${filepath}"
   fi
}

__ensure_plugin 'https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm'
__ensure_plugin 'https://github.com/cristiand391/zj-quit/releases/latest/download/zj-quit.wasm'

unset -f __ensure_plugin
