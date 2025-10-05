source "${ZRCDIR}/base.zsh"
source "${ZRCDIR}/prompt.zsh"

source-safe() {
   if [[ -f "$1" ]]; then
      source "$1"
   fi
}

source-safe "${HOME}/.zshrc.local"
source-safe "${ZDOTDIR}/.zshrc.local"
