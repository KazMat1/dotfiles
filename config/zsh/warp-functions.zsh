# --------------------
# Settings for Warp  
# --------------------

# --------------------
# search repository function without bind key. 
# combination of peco and ghq
# --------------------
function g () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    cd ${selected_dir}
  fi
}
