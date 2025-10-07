command -v zoxide &>/dev/null && eval "$(zoxide init zsh --no-cmd)"

export _ZO_FZF_OPTS="${FZF_DEFAULT_OPTS}"" --preview \"echo {} | awk '{print \$2}' | xargs eza -T -L=2 --color=always\""

if command -v __zoxide_zi >/dev/null 2>&1; then
   cd() {
      if [[ $# == 0 ]]; then
         __zoxide_zi
      else
         builtin cd -- "$@"
      fi
   }
fi
