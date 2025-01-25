# --------------------
# cd
# --------------------
alias ..="cd .."
alias cdg="cd $HOME/ghq/github.com"
alias cds="cd $HOME/.ssh"
alias cdot="cd $DOTFILES_DIR"

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
alias lw="less -iMN $DOTFILES_CONFIG_DIR/zsh/warp-functions.zsh"
alias la="less -iMN $DOTFILES_CONFIG_DIR/zsh/alias.zsh"
alias lzc="less -iMN $HOME/.zshrc"

# --------------------
# ghq
# --------------------
# update all repositories under ghq
alias gua="ghq list | ghq get -u -P"
