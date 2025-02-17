# --------------------
# Settings for Warp  
# --------------------

# --------------------
# search repository without bind key. 
# combination of peco and ghq
# --------------------
function g () {
  cd-selected-repo
}

# --------------------
# select commit for fixup in current repository without bind key. 
# combination of peco and git 
# --------------------
function f () {
  fixup-selected-commit
}