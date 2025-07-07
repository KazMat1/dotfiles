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
function install-input-repositories() {
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
# install all repositories under the owner with gh cli
# --------------------
function install-selected-repositories() {
    GITHUB_OWNER = gh org list | peco

    if [ -z "$GITHUB_OWNER" ]; then
        echo ":warning: \033[31m No input provided. Please enter the owner again :\033[31m"
        read -r GITHUB_OWNER
        if [ -z "$GITHUB_OWNER" ]; then
            echo ":no_entry_sign: \033[31m No input provided. Exiting...\033[31m"
            return 1
        fi
    fi
  gh repo list $GITHUB_OWNER | awk '{print "ghq", "get", "git@github.com:"$1".git"}' | bash
}

# --------------------
# switch branch you selected
# --------------------
function switch-selected-branch() {
  local selected_branch=$(git branch | peco | awk '{print $1}')
  if [ -n "$selected_branch" ]; then
    git switch $selected_branch
  fi
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

function get-pr-list () {
  # 特定期間のPRを取得（JSON形式）
  gh pr list \
    --repo sensyn-robotics/plant-check \
    --state all \
    --limit 100 \
    --json number,title,createdAt,closedAt,state \
    --jq '.[] | select(.createdAt >= "2024-01-01T00:00:00Z" and .createdAt <= "2024-12-31T23:59:59Z")'
}

# シンプル版（リポジトリのみ指定）
function pr_analysis() {
    local repo="$1"
    if [[ -z "$repo" ]]; then
        echo "Usage: pr_analysis owner/repository"
        return 1
    fi

    local before_start="2025-01-01T00:00:00Z"
    local before_end="2025-03-07T23:59:59Z"
    local after_start="2025-03-08T00:00:00Z"
    local after_end="2025-06-30T23:59:59Z"

    echo "=== 改善前 ==="
    gh pr list --repo "$repo" --state closed --limit 200 \
      --json createdAt,mergedAt \
      --jq "[.[] | select(.createdAt >= \"$before_start\" and .createdAt <= \"$before_end\" and .mergedAt != null)] |
        \"Count: \(length), Average: \(if length > 0 then (map((.mergedAt | fromdateiso8601) - (.createdAt | fromdateiso8601)) | add / length / 3600 | floor) else 0 end) hours\""

    echo "=== 改善後 ==="
    gh pr list --repo "$repo" --state closed --limit 200 \
      --json createdAt,mergedAt \
      --jq "[.[] | select(.createdAt >= \"$after_start\" and .createdAt <= \"$after_end\" and .mergedAt != null)] |
        \"Count: \(length), Average: \(if length > 0 then (map((.mergedAt | fromdateiso8601) - (.createdAt | fromdateiso8601)) | add / length / 3600 | floor) else 0 end) hours\""
}

function pr_analysis_by_count() {
    local repo="$1"
    local improvement_date="$2"
    local count="$3"

    if [[ -z "$repo" || -z "$improvement_date" || -z "$count" ]]; then
        echo "Usage: pr_analysis_by_count owner/repository improvement_date count"
        echo "Example: pr_analysis_by_count sensyn-robotics/plant-check 2025-03-08T00:00:00Z 10"
        return 1
    fi

    echo "=== 改善前（改善日より前の${count}個のPR） ==="
    gh pr list --repo "$repo" --state closed --limit 500 \
      --json createdAt,mergedAt \
      --jq "[.[] | select(.createdAt < \"$improvement_date\" and .mergedAt != null)] |
        sort_by(.createdAt) | reverse | .[0:$count] |
        \"Count: \(length), Average: \(if length > 0 then (map((.mergedAt | fromdateiso8601) - (.createdAt | fromdateiso8601)) | add / length / 3600 | floor) else 0 end) hours\""

    echo "=== 改善後（改善日以降の${count}個のPR） ==="
    gh pr list --repo "$repo" --state closed --limit 500 \
      --json createdAt,mergedAt \
      --jq "[.[] | select(.createdAt >= \"$improvement_date\" and .mergedAt != null)] |
        sort_by(.createdAt) | .[0:$count] |
        \"Count: \(length), Average: \(if length > 0 then (map((.mergedAt | fromdateiso8601) - (.createdAt | fromdateiso8601)) | add / length / 3600 | floor) else 0 end) hours\""
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
