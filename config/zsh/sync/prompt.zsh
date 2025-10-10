if [[ -n "$SSH_CONNECTION" ]]; then
   hostpart="%F{10}%n@%m%f"
else
   hostpart="%F{10}%n%f"
fi

PROMPT="$hostpart"':%F{14}%~%f'$'\n''❯ '
