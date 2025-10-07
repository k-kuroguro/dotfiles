command -v gh &>/dev/null && eval "$(gh completion -s zsh)"
command -v uv &>/dev/null && eval "$(uv generate-shell-completion zsh)"
command -v rg &>/dev/null && eval "$(rg --generate complete-zsh)"
command -v deno &>/dev/null && eval "$(deno completions zsh)"
command -v fx &>/dev/null && source <(fx --comp zsh)
command -v miniserve &>/dev/null && source <(miniserve --print-completions zsh)
command -v watchexec &>/dev/null && source <(watchexec --completions zsh)
