export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZCACHEDIR="${XDG_CACHE_HOME}/zsh"
export ZSTATEDIR="${XDG_STATE_HOME}/zsh"

export DOTFILES_DIR="${HOME}/dotfiles"

mkdir -p "${ZCACHEDIR}" "${ZSTATEDIR}"

setopt no_global_rcs           # Skip sourcing `/etc/z*` files except `/etc/zshenv`.
export skip_global_compinit=1  # Skip system-wide compinit in `/etc/zshrc`.

typeset -U path PATH
path=(
   "${HOME}/.local/share/mise/shims"(N-/)
	"${HOME}/bin"(N-/)
	"${HOME}/.local/bin"(N-/)
	"${HOME}/.cargo/bin"(N-/)
	"${HOME}/.deno/bin"(N-/)
	"${HOME}/.luarocks/bin"(N-/)
   "${DOTFILES_DIR}/bin"(N-/)
	"${(@)path}"
)
export PATH

fpath=(
	"${ZDOTDIR}/completions.local"(N-/)
	'/usr/local/share/zsh/site-functions'(N-/)
	'/usr/share/zsh/site-functions'(N-/)
	"${(@)fpath}"
)
export FPATH

if [[ -f "${ZDOTDIR}/.zshenv.local" ]]; then
   source "${ZDOTDIR}/.zshenv.local"
fi
