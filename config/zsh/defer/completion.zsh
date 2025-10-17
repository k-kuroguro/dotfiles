ensure_completion() {
	local gen_cmd="$1"
	local filename="$2"
	local dir="${ZDOTDIR}/completions.local"
	local filepath="${dir}/${filename}"

	if [[ ! -r "${filepath}" ]]; then
		eval "${gen_cmd}" > "${filepath}"
	fi
}

ensure_completion_from_url() {
   local url="$1"
   local filename="$2"
   ensure_completion "curl -fsSL '${url}'" "${filename}"
}

ensure_completion 'gh completion -s zsh' '_gh'
ensure_completion 'uv generate-shell-completion zsh' '_uv'
ensure_completion 'uvx --generate-shell-completion zsh' '_uvx'
ensure_completion 'deno completions zsh' '_deno'
ensure_completion 'miniserve --print-completions zsh' '_miniserve'
ensure_completion 'watchexec --completions zsh' '_watchexec'
ensure_completion 'wezterm shell-completion --shell zsh' '_wezterm'
ensure_completion 'aqua completion zsh' '_aqua'
ensure_completion 'fx --comp zsh' '_fx'
ensure_completion 'rg --generate complete-zsh' '_rg'
ensure_completion 'zellij setup --generate-completion zsh' '_zellij'
ensure_completion 'bat --completion zsh' '_bat'
ensure_completion 'rustup completions zsh' '_rustup'
ensure_completion 'rustup completions zsh cargo' '_cargo'

ensure_completion_from_url 'https://raw.githubusercontent.com/sharkdp/fd/refs/heads/master/contrib/completion/_fd' '_fd'
ensure_completion_from_url 'https://raw.githubusercontent.com/ajeetdsouza/zoxide/refs/heads/main/contrib/completions/_zoxide' '_zoxide'
ensure_completion_from_url 'https://raw.githubusercontent.com/eza-community/eza/refs/heads/main/completions/zsh/_eza' '_eza'
ensure_completion_from_url 'https://raw.githubusercontent.com/alacritty/alacritty/refs/heads/master/extra/completions/_alacritty' '_alacritty'

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

autoload -Uz compinit
compinit -d "${ZCACHEDIR}/zcompdump-${ZSH_VERSION}"
