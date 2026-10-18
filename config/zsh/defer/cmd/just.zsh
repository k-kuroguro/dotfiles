fzf_just() {
   local choice=$(
      {
         echo $'name\targs\tdoc'
         just -g --dump-format=json --dump | \
         yq -r '
            .recipes
            | to_entries
            | map(select(.value.private != true))
            | map(with(select(.value.parameters | any | not); .value.parameters = null))
            | map({
               "name": .value.name,
               "args": (.value.parameters // [{"name":"-"}] | map(.name) | join(",")),
               "doc": (.value.doc // "")
            })
            | .[]
            | "\(.name)	\(.args)	\(.doc)"
         '
      } | \
      column -t -s $'\t' | \
      fzf --preview 'just -g --show {1}' --header-lines=1
   )
   local ret=$?

   if [[ -n ${choice} ]]; then
      local recipe_name="${choice%% *}"
      local post_script=$(just -g --dump-format=json --dump | \
         yq -r ".recipes.${recipe_name}.attributes.[] | select(.metadata) | .metadata | join(\"; \")"
      )
      LBUFFER="just -g ${recipe_name} "
      if [[ -n $post_script ]]; then
         RBUFFER="; ${post_script}"
      fi
   fi

   zle reset-prompt
   return ${ret}
}

zle -N fzf_just
bindkey '^P' fzf_just
