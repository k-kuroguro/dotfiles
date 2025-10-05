export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZRCDIR="${ZDOTDIR}/rc"

export DOTFILES_DIR="${HOME}/dotfiles"

setopt no_global_rcs           # Skip sourcing /etc/z* files except /etc/zshenv.
export skip_global_compinit=1  # Skip system-wide compinit.

typeset -U path PATH
path=(
	"${HOME}/bin"(N-/)
	"${HOME}/.local/bin"(N-/)
	"${HOME}/.cargo/bin"(N-/)
	"${HOME}/.deno/bin"(N-/)
   "${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin"(N-/)
   "${DOTFILES_DIR}/bin"(N-/)
	"${(@)path}"
)
export PATH

if [[ -f "${HOME}/.zshenv.local" ]]; then
   source "${HOME}/.zshenv.local"
fi
if [[ -f "${ZDOTDIR}/.zshenv.local" ]]; then
   source "${ZDOTDIR}/.zshenv.local"
fi
