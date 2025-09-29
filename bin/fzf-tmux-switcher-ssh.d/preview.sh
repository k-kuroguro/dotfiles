#!/bin/bash

IFS= read -r line

host=$(echo "${line}" | cut -f1)
info=$(echo "${line}" | cut -f2)

session=$(echo "${info}" | cut -d: -f1)
index=$(echo "${info}" | cut -d: -f2)

if [[ "${host}" == 'local' ]]; then
   tmux capture-pane -ep -t "${session}:${index}" | tac | awk '/[^[:space:]]/ {p=1} p' | tac
else
   ssh -o ConnectTimeout=2 -o BatchMode=yes "${host}" "tmux capture-pane -ep -t '${session}:${index}'" 2>/dev/null | tac | awk '/[^[:space:]]/ {p=1} p' | tac
fi
