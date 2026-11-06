if command -v atuin &>/dev/null; then
   source <(atuin init zsh --disable-up-arrow)

   bindkey '^]' atuin-ai-resume
fi
