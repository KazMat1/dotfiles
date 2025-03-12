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
# display current branch
# --------------------
function display-current-branch() {
  git branch --show-current
}

# --------------------
# install all repositories under the owner
# --------------------
function install-all-repositories() {
    echo "🙏 Please enter the owner whose you want to clone repositories :"
    read -r GITHUB_OWNER

    if [ -z "$GITHUB_OWNER" ]; then
        echo "⚠️ \033[31m No input provided. Please enter the owner again :\033[31m"
        read -r GITHUB_OWNER
        if [ -z "$GITHUB_OWNER" ]; then
            echo "🚫 \033[31m No input provided. Exiting...\033[31m"
            return 1
        fi
    fi
  gh repo list $GITHUB_OWNER | awk '{print "ghq", "get", "git@github.com:"$1".git"}' | bash
}

# --------------------
# stash current changes and reset --hard based on remote of current branch
# --------------------
function stash-changes-and-force-pull-in-current-branch() {
#   git stash save "force pull の stash" -u && git fetch --prune && git reset --hard origin/$(git branch --contains | cut -d " " -f 2)
  git stash save "force pull の stash" -u && git fetch --prune && git reset --hard origin/$(display-current-branch)
}

# --------------------
# summarize diff output between current branch and main
# --------------------
function summarize-diff-with-main() {
    MAIN_BRANCH="main"
    if [ $(display-current-branch) = $MAIN_BRANCH ]; then
        echo "🚫 \033[31m You are already in main. Exiting...\033[31m"
        return 1
    else
        git diff --shortstat $MAIN_BRANCH
    fi
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
