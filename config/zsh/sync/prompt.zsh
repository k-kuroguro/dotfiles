__prompt_command_timer_preexec() {
   __prompt_timer_start_ms=$(( $(printf "%.0f" "${EPOCHREALTIME} * 1000") ))
   __prompt_elapsed_time=''
}

__prompt_command_timer_precmd() {
   if [[ -n "${__prompt_timer_start_ms}" ]]; then
      local __timer_end_ms=$(( $(printf "%.0f" "${EPOCHREALTIME} * 1000") ))
      local elapsed_ms=$(( __timer_end_ms - __prompt_timer_start_ms ))

      if (( elapsed_ms > 0 )); then
         __prompt_elapsed_time=" [%F{3}󱦟 $(pretty_ms "${elapsed_ms}")%f]"
      else
         __prompt_elapsed_time=''
      fi

      unset __prompt_timer_start_ms
   else
      __prompt_elapsed_time=""
   fi
}

add-zsh-hook preexec __prompt_command_timer_preexec
add-zsh-hook precmd __prompt_command_timer_precmd

ZSH_THEME_GIT_PROMPT_PREFIX=$' [ '
ZSH_THEME_GIT_PROMPT_SUFFIX=']'
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR='|'
ZSH_THEME_GIT_PROMPT_UNMERGED='!'
ZSH_THEME_GIT_PROMPT_STAGED='+'
ZSH_THEME_GIT_PROMPT_UNSTAGED='*'
ZSH_THEME_GIT_PROMPT_UNTRACKED='?'
ZSH_THEME_GIT_PROMPT_STASHED='$'
ZSH_THEME_GIT_PROMPT_CLEAN=''
ZSH_GIT_PROMPT_SHOW_STASH=1
# Display git prompt, removing the separator if no git status symbols are present.
__prompt_git() {
   local raw="$(gitprompt)"
   local symbols="${ZSH_THEME_GIT_PROMPT_UNMERGED}${ZSH_THEME_GIT_PROMPT_STAGED}${ZSH_THEME_GIT_PROMPT_UNSTAGED}${ZSH_THEME_GIT_PROMPT_UNTRACKED}${ZSH_THEME_GIT_PROMPT_STASHED}"

   if [[ "${raw}" != *["$symbols"]* ]]; then
      raw="${raw/${ZSH_THEME_GIT_PROMPT_SEPARATOR}/}"
   fi
   echo -n "${raw}"
}

VIRTUAL_ENV_DISABLE_PROMPT=1
__prompt_python() {
   if [[ -n "${VIRTUAL_ENV:+x}" ]] && command -v python &>/dev/null; then
      local env_name="$(echo "${VIRTUAL_ENV_PROMPT//[()]/}" | xargs)"
      if [[ -z "${env_name}" ]]; then
         env_name="$(basename "${VIRTUAL_ENV}")"
      fi

      echo -n " [󰌠 ${env_name}@$(python -V |& cut -d " " -f2)]"
   fi
}

typeset -g __prompt_rust=''
__prompt_rust_job() {
   if ! command -v rustc &>/dev/null; then
      return
   fi

   local dir="$1"
   while [[ "${dir}" != '/' ]]; do
      if [[ -f "${dir}/Cargo.toml" ]]; then
         local ver="$(rustc -V | cut -d ' ' -f2)"
         echo -n " [󱘗 ${ver}]"
         return
      fi
      dir="$(dirname "${dir}")"
   done
}

typeset -g __prompt_deno=''
__prompt_deno_job() {
   if ! command -v deno &>/dev/null; then
      return
   fi

   local dir="$1"
   while [[ "${dir}" != '/' ]]; do
      if [[ -f "${dir}/deno.json" || -f "${dir}/deno.jsonc" ]]; then
         local ver="$(deno -V | cut -d ' ' -f2)"
         echo -n " [ ${ver}]"
         return
      fi
      dir="$(dirname "${dir}")"
   done
}

typeset -g __prompt_gcloud=''
__prompt_gcloud_job() {
   local enabled=$1

   if ! command -v gcloud &>/dev/null || [[ "${enabled}" != "1" ]]; then
      return
   fi

   local config_dir="${CLOUDSDK_CONFIG:-${HOME}/.config/gcloud}"
   if [[ -f "${config_dir}/active_config" ]]; then
      local active_config="$(< "${config_dir}/active_config")"
      # local project="$(yq -r -p=ini '.core.project' "${config_dir}/configurations/config_${active_config}" 2>/dev/null)"
      echo -n " [󱇶 ${active_config}]"
   fi
}

__prompt_callback() {
   local job_name=$1 return_code=$2 output=$3 elapsed=$4 stderr=$5 has_next=$6

   case ${job_name} in
      __prompt_deno_job) __prompt_deno="${output}" ;;
      __prompt_rust_job) __prompt_rust="${output}" ;;
      __prompt_gcloud_job) __prompt_gcloud="${output}" ;;
   esac

   (( has_next == 0 )) && zle && zle reset-prompt
}

__prompt() {
   local exit_code=$?

   local prompt_symbol
   if (( exit_code == 0 )); then
      prompt_symbol='❯'
   else
      prompt_symbol='%F{9}❯%f'
   fi

   local prompt_host
   if [[ -n "${SSH_CONNECTION}" ]]; then
      prompt_host='%F{10}@%m%f'
   else
      prompt_host=''
   fi

   echo '%F{10}%n%f'"${prompt_host}"":%F{14}%~%f$(__prompt_git)$(__prompt_python)${__prompt_rust}${__prompt_gcloud}${__prompt_elapsed_time}"$'\n'"${prompt_symbol} "
}

PROMPT='$(__prompt)'

async_stop_worker __prompt_worker 2>/dev/null
async_start_worker __prompt_worker
async_unregister_callback __prompt_worker 2>/dev/null
async_register_callback __prompt_worker __prompt_callback

__prompt_pre_cmd() {
   async_flush_jobs __prompt_worker

   __prompt_rust=''
   async_job __prompt_worker __prompt_rust_job "${PWD}"

   # __prompt_deno=''
   # async_job __prompt_worker __prompt_deno_job "${PWD}"

   __prompt_gcloud=''
   async_job __prompt_worker __prompt_gcloud_job "${PROMPT_GCLOUD_ENABLED:-0}"
}

add-zsh-hook precmd __prompt_pre_cmd
