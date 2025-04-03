#!/bin/bash

DOTFILES_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
TARGET_FILES=(".bashrc" ".bash_aliases")

if [ "$HOME" = "$DOTFILES_DIR" ]; then
   echo "Dotfiles directory and home directory are the same. No action needed."
   exit 0
fi

for file in "${TARGET_FILES[@]}"; do
   SRC="$DOTFILES_DIR/$file"
   DEST="$HOME/$file"

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
