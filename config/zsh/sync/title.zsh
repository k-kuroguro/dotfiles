title_preexec() {
  print -Pn "\e]2;${1%% *} @ %~\a"
}

function title_precmd() {
  print -Pn "\e]2;zsh @ %~\a"
}

add-zsh-hook preexec title_preexec
add-zsh-hook precmd title_precmd

title_precmd
