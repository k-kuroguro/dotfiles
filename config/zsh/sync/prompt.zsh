__prompt_command_timer_preexec() {
   prompt_timer_start_ms=$(( $(printf "%.0f" "${EPOCHREALTIME} * 1000") ))
   prompt_elapsed_time=''
}

__prompt_command_timer_precmd() {
   if [[ -n "${prompt_timer_start_ms}" ]]; then
      local __timer_end_ms=$(( $(printf "%.0f" "${EPOCHREALTIME} * 1000") ))
      local elapsed_ms=$(( __timer_end_ms - prompt_timer_start_ms ))

      if (( elapsed_ms > 0 )); then
         prompt_elapsed_time=" [%F{3}󱦟 $(pretty_ms "${elapsed_ms}")%f]"
      else
         prompt_elapsed_time=''
      fi

      unset prompt_timer_start_ms
   else
      prompt_elapsed_time=""
   fi
}

if [[ -n "${SSH_CONNECTION}" ]]; then
   prompt_host='%F{10}@%m%f'
else
   prompt_host=''
fi

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

__prompt_python() {
   if [[ -n "${VIRTUAL_ENV:+x}" ]] && command -v python &>/dev/null; then
      local env_name="$(echo "${VIRTUAL_ENV_PROMPT//[()]/}" | xargs)"
      if [[ -z "${env_name}" ]]; then
         env_name="$(basename "${VIRTUAL_ENV}")"
      fi

      echo -n " [󰌠 ${env_name}@$(python -V |& cut -d " " -f2)]"
   fi
}

__prompt_rust() {
   local dir="${PWD}"
   while [[ "${dir}" != '/' ]]; do
      if [[ -f "${dir}/Cargo.toml" ]]; then
         if command -v rustc &>/dev/null; then
            local ver="$(rustc -V | cut -d ' ' -f2)"
            echo -n " [󱘗 ${ver}]"
         fi
         return
      fi
      dir="$(dirname "${dir}")"
   done
}

PROMPT='%F{10}%n%f'"${prompt_host}"':%F{14}%~%f$(__prompt_git)$(__prompt_python)$(__prompt_rust)${prompt_elapsed_time}'$'\n''❯ '

add-zsh-hook preexec __prompt_command_timer_preexec
add-zsh-hook precmd __prompt_command_timer_precmd
