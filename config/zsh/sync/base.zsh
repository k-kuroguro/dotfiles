HISTFILE="${ZSTATEDIR}/history"
HISTSIZE=10000
SAVEHIST=100000
HISTORY_IGNORE="(ls|cd|pwd|zsh|exit|history)"
LISTMAX=1000 # Ask when the number of completion lines exceeds this value.

typeset -g WORDCHARS="${WORDCHARS:s@/@}" # Treat `/` as a word separator allowing `C-w` to delete path segments.
