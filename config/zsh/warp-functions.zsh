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
# display current branch without bind key.
# --------------------
function c () {
  display-current-branch
}

# --------------------
# display current branch without bind key.
# --------------------
function s () {
  switch-selected-branch
}

# --------------------
# select commit for fixup in current repository without bind key.
# combination of peco and git
# --------------------
function f () {
  fixup-selected-commit
}

# --------------------
# select commit for fixup in current repository without bind key.
# combination of peco and git
# --------------------
function d () {
  summarize-diff-with-main
}
