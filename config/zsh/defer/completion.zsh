__ensure_completion() {
	local cmd_name="$1"
   local gen_cmd="$2"
   local filename="$3"
   local dir="${ZDOTDIR}/completions.local"
   local filepath="${dir}/${filename}"

   if ! command -v "${cmd_name}" >/dev/null 2>&1; then
      return
   fi

   if [[ ! -r "${filepath}" ]]; then
      eval "${gen_cmd}" > "${filepath}"
   fi
}

__ensure_completion_from_url() {
	local cmd_name="$1"
   local url="$2"
   local filename="$3"
   __ensure_completion "${cmd_name}" "curl -fsSL '${url}'" "${filename}"
}

__ensure_completion 'aqua' 'aqua completion zsh' '_aqua'
__ensure_completion 'bat' 'bat --completion zsh' '_bat'
__ensure_completion 'deno' 'deno completions zsh' '_deno'
__ensure_completion 'fx' 'fx --comp zsh' '_fx'
__ensure_completion 'gh' 'gh completion -s zsh' '_gh'
__ensure_completion 'just' 'just --completions zsh' '_just'
__ensure_completion 'miniserve' 'miniserve --print-completions zsh' '_miniserve'
__ensure_completion 'pueue' 'pueue completions zsh' '_pueue'
__ensure_completion 'rg' 'rg --generate complete-zsh' '_rg'
__ensure_completion 'rustup' 'rustup completions zsh cargo' '_cargo'
__ensure_completion 'rustup' 'rustup completions zsh' '_rustup'
__ensure_completion 'uv' 'uv generate-shell-completion zsh' '_uv'
__ensure_completion 'uvx' 'uvx --generate-shell-completion zsh' '_uvx'
__ensure_completion 'watchexec' 'watchexec --completions zsh' '_watchexec'
__ensure_completion 'wezterm' 'wezterm shell-completion --shell zsh' '_wezterm'
__ensure_completion 'yq' 'yq shell-completion zsh' '_yq'
__ensure_completion 'zellij' 'zellij setup --generate-completion zsh' '_zellij'

__ensure_completion 'btm' 'cmd_path=$(aqua which btm 2>/dev/null) && cat "$(dirname "${cmd_path}")/completion/_btm"' '_btm'
__ensure_completion 'hurl' 'cmd_path=$(aqua which hurl 2>/dev/null) && cat "$(dirname "$(dirname "${cmd_path}")")/completions/_hurl"' '_hurl'
__ensure_completion 'hurlfmt' 'cmd_path=$(aqua which hurlfmt 2>/dev/null) && cat "$(dirname "$(dirname "${cmd_path}")")/completions/_hurlfmt"' '_hurlfmt'
__ensure_completion 'hyperfine' 'cmd_path=$(aqua which hyperfine 2>/dev/null) && cat "$(dirname "${cmd_path}")/autocomplete/_hyperfine"' '_hyperfine'
__ensure_completion 'xh' 'cmd_path=$(aqua which xh 2>/dev/null) && cat "$(dirname "${cmd_path}")/completions/_xh"' '_xh'

__ensure_completion_from_url 'alacritty' 'https://raw.githubusercontent.com/alacritty/alacritty/refs/heads/master/extra/completions/_alacritty' '_alacritty'
__ensure_completion_from_url 'eza' 'https://raw.githubusercontent.com/eza-community/eza/refs/heads/main/completions/zsh/_eza' '_eza'
__ensure_completion_from_url 'fd' 'https://raw.githubusercontent.com/sharkdp/fd/refs/heads/master/contrib/completion/_fd' '_fd'
__ensure_completion_from_url 'zoxide' 'https://raw.githubusercontent.com/ajeetdsouza/zoxide/refs/heads/main/contrib/completions/_zoxide' '_zoxide'

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

autoload -Uz compinit
compinit -d "${ZCACHEDIR}/zcompdump-${ZSH_VERSION}"

unset -f __ensure_completion __ensure_completion_from_url
