# Convert a duration given in milliseconds into a human-readable format.
# Based on: https://github.com/sindresorhus/pretty-time-zsh.
#
# Arguments:
#   Integer duration in milliseconds.
# Outputs:
#   Write the formatted duration string to stdout according to the rules below:
#     - < 1s → 'XXXms'
#     - < 1m → 'X.Ys'  (milliseconds as fractional seconds)
#     - ≥ 1m → 'Xm Ys' (milliseconds truncated)
pretty_ms() {
   if (( $# == 0 )); then
      echo "Usage: pretty_ms <milliseconds>" >&2
      return 1
   fi

   local human="" total_ms="$1"

   local total_seconds=$(( total_ms / 1000 ))
   local ms=$(( total_ms % 1000 ))
   local days=$(( total_seconds / 86400 ))
   local hours=$(( (total_seconds / 3600) % 24 ))
   local minutes=$(( (total_seconds / 60) % 60 ))
   local seconds=$(( total_seconds % 60 ))

   if (( total_ms < 1000 )); then
      human="${ms}ms"
   elif (( total_ms < 60000 )); then
      local ms_digit=$(( ms / 100 ))
      human="${seconds}.${ms_digit}s"
   else
      (( days > 0 )) && human+="${days}d "
      (( hours > 0 )) && human+="${hours}h "
      (( minutes > 0 )) && human+="${minutes}m "
      human+="${seconds}s"
   fi

   echo "${human}"
}
