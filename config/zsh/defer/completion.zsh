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

__ensure_completion 'herdr' 'herdr completion zsh' '_herdr'
__ensure_completion 'codex' 'codex completion zsh' '_codex'
__ensure_completion 'mise' 'mise completion zsh' '_mise'
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
__ensure_completion 'yq' 'yq shell-completion zsh' '_yq'
__ensure_completion 'tuios' 'tuios completion zsh' '_tuios'

__ensure_completion 'btm' 'cmd_path=$(mise which btm 2>/dev/null) && cat "${cmd_path:h:h}/completion/_btm"' '_btm'
__ensure_completion 'hyperfine' 'cmd_path=$(mise which hyperfine 2>/dev/null) && cat "${cmd_path:h:h}/autocomplete/_hyperfine"' '_hyperfine'

__ensure_completion_from_url 'eza' 'https://raw.githubusercontent.com/eza-community/eza/refs/heads/main/completions/zsh/_eza' '_eza'
__ensure_completion_from_url 'fd' 'https://raw.githubusercontent.com/sharkdp/fd/refs/heads/master/contrib/completion/_fd' '_fd'
__ensure_completion_from_url 'zoxide' 'https://raw.githubusercontent.com/ajeetdsouza/zoxide/refs/heads/main/contrib/completions/_zoxide' '_zoxide'

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"

autoload -Uz compinit
compinit -d "${ZCACHEDIR}/zcompdump-${ZSH_VERSION}"

unset -f __ensure_completion __ensure_completion_from_url
