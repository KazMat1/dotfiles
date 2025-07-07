#!/bin/zsh

# Homebrewのインストール
install_brew_command() {
    echo "🚀 Setting up Homebrew..."

    if ! brew_path=$(command -v brew); then
        echo "💪 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        execute_next_step_after_install_brew_command
    else
        echo "👋 Homebrew is already installed at $brew_path."
    fi
}

install_brew_packages_and_apps() {
    echo "💪 Updating Homebrew..."
    brew update

    echo "💪 Installing packages and apps..."
    brew bundle --file=$HOME/dotfiles/config/brew/Brewfile

    echo "✅ installation has complete!"
}

# brew のインストール後に、表示される次のステップを実行
execute_next_step_after_install_brew_command() {
    echo "💪 Execute next step actions..."
    echo >> $HOME/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_brew_command
install_brew_packages_and_apps
