#!/bin/bash

DOTFILES_DIR=$(cd $(dirname $(dirname ${BASH_SOURCE:-$0})); pwd)
TARGET_FILES=("config/bash/.bashrc" "config/bash/.bash_aliases")
DESTS=($HOME/.bashrc $HOME/.bash_aliases)

if [ "$HOME" = "$DOTFILES_DIR" ]; then
   echo "Dotfiles directory and home directory are the same. No action needed."
   exit 0
fi

for i in "${!TARGET_FILES[@]}"; do
   SRC="$DOTFILES_DIR/${TARGET_FILES[$i]}"
   DEST="${DESTS[$i]}"

   if [ ! -e "$SRC" ]; then
      echo "$SRC does not exist. Skipping."
      continue
   fi

   if [ -e "$DEST" ] || [ -L "$DEST" ]; then
      while true; do
         read -r -p "$DEST already exists as a $TYPE. Overwrite? (y/n) " answer
         if [ "$answer" == "y" ]; then
            break
         elif [ "$answer" == "n" ] || [ -z "$answer" ]; then
            echo "Skipping $DEST."
            continue 2
         else
            echo "Invalid input. Please enter 'y' or 'n'."
         fi
      done
   fi

   ln -sf "$SRC" "$DEST"
   echo "Linked $DEST -> $SRC"
done

echo "Setting up gitconfig include..."
gitconfig=$DOTFILES_DIR/config/git/.gitconfig
git config --global --add include.path "$gitconfig"
echo "Included $gitconfig in global gitconfig."
