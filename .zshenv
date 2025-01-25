# dotfiles path
# export DOTFILES_DIR="~/dotfiles"
# export DOTFILES_SCRIPTS_DIR="$DOTFILES_DIR/scripts"
# export DOTFILES_CONFIG_DIR="$DOTFILES_DIR/config"
# export DOTFILES_SETUP_SCRIPTS_DIR="$DOTFILES_SCRIPTS_DIR/setup"
# export DOTFILES_UTILS_SCRIPTS_DIR="$DOTFILES_SCRIPTS_DIR/utils"

# history
export HISTSIZE=10000
export SAVEHIST=10000

# NOTE: execute_next_step_after_install_brew_command で実行している内容で
#       .zprofileに追記しているのでいらないかも？
# Homebrew のパス設定
# if [ -d "/opt/homebrew/bin" ]; then
#     # for Apple Silicon chip
#     export PATH="/opt/homebrew/bin:$PATH"
#     # for Intel chip
# elif [ -d "/usr/local/bin" ]; then
#     export PATH="/usr/local/bin:$PATH"
# fi