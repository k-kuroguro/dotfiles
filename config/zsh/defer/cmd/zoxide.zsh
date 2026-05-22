command -v zoxide &>/dev/null && source <(zoxide init zsh --no-cmd)

if command -v zoxide >/dev/null 2>&1; then
   __zoxide_zi() {
      __zoxide_doctor
      \builtin local result
      result="$(zoxide query -ls -- "$@" | fzf --preview 'echo {} | awk "{print \$2}" | xargs eza -T -L=2 --color=always')" && __zoxide_cd "$(echo "$result" | awk '{print $2}')"
   }

   cd() {
      if [[ $# == 0 ]]; then
         __zoxide_zi
      else
         builtin cd -- "$@"
      fi
   }
fi
