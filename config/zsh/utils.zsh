# --------------------
# utility functions
# --------------------

# --------------------
# delete merged branches without protect branches
# --------------------
function delete-merged-branches () {
  local protected_branches='main|master|development|staging|release'
  git branch --merged | egrep -v "\*|${protected_branches}" | xargs git branch -d;
}

# --------------------
# stash current changes and reset --hard based on remote of current branch
# --------------------
function stash-changes-and-force-pull-in-current-branch () {
  git stash save "force pull の stash" -u && git fetch --prune && git reset --hard origin/$(git branch --contains | cut -d " " -f 2)
}

# --------------------
# summarize diff output between current branch and main
# --------------------
function summarize-diff-with-main () {
  git diff --shortstat main
}