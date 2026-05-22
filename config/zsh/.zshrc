# Cache `sheldon source`.
if command -v sheldon >/dev/null; then
   export SHELDON_CONFIG_DIR="${ZDOTDIR}/sheldon"
   sheldon_cache="${ZCACHEDIR}/sheldon.zsh"
   sheldon_toml="${SHELDON_CONFIG_DIR}/plugins.toml"
   if [[ ! -r "${sheldon_cache}" || "${sheldon_toml}" -nt "${sheldon_cache}" ]]; then
      sheldon source > "${sheldon_cache}"
   fi
   source "${sheldon_cache}"
   unset sheldon_cache sheldon_toml
fi

if [[ -f "${ZDOTDIR}/.zshrc.local" ]]; then
   source "${ZDOTDIR}/.zshrc.local"
fi
