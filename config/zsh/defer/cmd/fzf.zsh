type -p fzf &>/dev/null && source <(command fzf --zsh)

export FZF_DEFAULT_OPTS=$'--height 70% --tmux center,80%,border-native --reverse --ansi --bind \'ctrl-s:preview-half-page-down,ctrl-w:preview-half-page-up,ctrl-/:change-preview-window(80%|hidden|)\' --preview-border line --preview-window 50%,wrap'
export FZF_CTRL_R_OPTS=$'--preview \'echo {} | bat --color=always --language=sh --style=plain\''
export FZF_CTRL_T_OPTS=$'--preview \'bat --color=always --style=plain {}\''
export FZF_ALT_C_OPTS=$'--preview \'eza -T -L=2 --color=always {}\''
export FZF_DEFAULT_COMMAND='fd --type f --hidden --color always'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND='fd --type d --hidden --color always'

_fzf_compgen_path() {
   fd --hidden --color always . "$1"
}

_fzf_compgen_dir() {
   fd --type d --hidden --color always . "$1"
}

_fzf_comprun() {
   local command="$1"
   shift

   case "${command}" in
      cd) fzf --preview 'eza -T -L=2 --color=always {}' "$@" ;;
      export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
      *) fzf "$@" ;;
   esac
}

if ! command -v fzf-zellij &> /dev/null; then
   curl -L https://raw.githubusercontent.com/k-kuroguro/fzf-zellij/refs/heads/main/bin/fzf-zellij -o ~/.local/bin/fzf-zellij
   chmod +x ~/.local/bin/fzf-zellij
fi

if command -v fzf-zellij &>/dev/null; then
   export FZF_ZELLIJ_WIDTH='70%'
   export FZF_ZELLIJ_HEIGHT='70%'
   export FZF_ZELLIJ_X='15%'
   export FZF_ZELLIJ_Y='20%'
   fzf() {
      case "$1" in
         --bash|--zsh|--fish|--version|-h|--help|--man)
            command fzf "$@"
            ;;
         *)
            fzf-zellij "$@"
            ;;
      esac
   }
fi
