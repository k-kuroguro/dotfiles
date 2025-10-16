zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

command -v gh &>/dev/null && source <(gh completion -s zsh)
command -v uv &>/dev/null && source <(uv generate-shell-completion zsh)
command -v deno &>/dev/null && source <(deno completions zsh)
command -v miniserve &>/dev/null && source <(miniserve --print-completions zsh)
command -v watchexec &>/dev/null && source <(watchexec --completions zsh)
command -v wezterm &>/dev/null && source <(wezterm shell-completion --shell zsh)
