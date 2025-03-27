# --------------------
# cd
# --------------------
alias ..="cd .."
alias cdg="cd $HOME/ghq/github.com"
alias cds="cd $HOME/.ssh"
alias cdot="cd $HOME/dotfiles"

# --------------------
# ls
# --------------------
alias ll="ls -la"

# --------------------
# code
# --------------------
alias code="code ."

# --------------------
# cursor
# --------------------
alias cursor="cursor ."

# --------------------
# open
# --------------------
alias open="open ."

# --------------------
# exit
# --------------------
alias e="exit"

# --------------------
# tmux
# --------------------
alias tx="tmux"
alias txa="tmux a"

# --------------------
# source
# --------------------
alias zrc="source $HOME/.zshrc"

# --------------------
# less
# --------------------
alias lw="less -iMN $HOME/dotfiles/config/zsh/warp-functions.zsh"
alias la="less -iMN $HOME/dotfiles/config/zsh/alias.zsh"
alias lzc="less -iMN $HOME/.zshrc"

# --------------------
# ghq
# --------------------
alias ghqg="ghq get"
# install all repositories by ghq
alias ghqga="install-all-repositories"
# update all repositories under ghq
alias ghqua="ghq list | ghq get -u -P"

# --------------------
# git
# --------------------
alias gaa="git add ."
alias gb="git branch"
alias gba="git branch -a"
alias gbm="git branch -m"
alias gbmg="git branch --merged"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gc="git commit"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gcf="git commit --fixup"
alias gds="summarize-diff-with-main"
alias gf="git fetch"
alias gfp="git fetch --prune"
alias gl="git log"
alias glo="git log --oneline"
alias gm="git merge"
alias gplo="git pull origin"
alias gpso="git push origin"
# 起動時にエラーが出るので一旦コメントアウト
# alias gploc="git pull origin $(display-current-branch)"
# alias gpsoc="git push origin $(display-current-branch)"
# alias grsth="git reset --hard origin/$(display-current-branch)"
# alias grst="git reset $(display-current-branch)"
alias gs="git switch"
alias gsc="git switch -c"
alias gst="git status"
alias gsts="git stash"
alias gstsa="git stash apply"
alias gstsu="git stash -u"
alias gstsl="git stash list"
alias gstsp="git stash pop"
alias gstss="git stash save"
alias gra='git rebase --autosquash -i'
