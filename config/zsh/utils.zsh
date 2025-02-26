# --------------------
# utility functions
# --------------------

# --------------------
# delete merged branches without protect branches
# --------------------
function delete-merged-branches() {
  local protected_branches='main|master|development|staging|release'
  git branch --merged | egrep -v "\*|${protected_branches}" | xargs git branch -d
}

# --------------------
# stash current changes and reset --hard based on remote of current branch
# --------------------
function stash-changes-and-force-pull-in-current-branch() {
  git stash save "force pull の stash" -u && git fetch --prune && git reset --hard origin/$(git branch --contains | cut -d " " -f 2)
}

# --------------------
# summarize diff output between current branch and main
# --------------------
function summarize-diff-with-main() {
  gds
}

# --------------------
# commit changes in staging with fixup to selected commit
# --------------------
function fixup-selected-commit() {
  local selected_commit=$(git log --oneline -n 20 | peco | awk '{print $1}')
  if [ -n "$selected_commit" ]; then
    git commit --fixup "$selected_commit"
  fi
}

# --------------------
# change directory to selected repository
# --------------------
function cd-selected-repo () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    cd ${selected_dir}
  fi
}


# --------------------
# notify whether success or failure to user with the sound
# --------------------
function notify () {
  if [ "$?" = 0 ]; then
    success
  else
    failure
  fi
}

function success () {
  afplay /System/Library/Sounds/Blow.aiff
}

function failure () {
  afplay /System/Library/Sounds/Bottle.aiff
}
