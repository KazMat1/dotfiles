# --------------------
# Settings for Item2 
# --------------------

# REF: https://blog.omuomugin.com/posts/2024-03-01/

# --------------------
# Search repository function with bind key(ctl + T), ctl + T
# combination of peco and ghq
# --------------------
# function peco-src () {
#   local selected_dir=$(ghq list -p | peco --prompt="repositories >" --query "$LBUFFER")
#   if [ -n "$selected_dir" ]; then
#     BUFFER="cd ${selected_dir}"
#     zle accept-line
#   fi
#   zle clear-screen
# }
# zle -N peco-src
# bindkey '^T' peco-src