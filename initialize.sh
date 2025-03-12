#!/bin/zsh

SCRIPT_SETUP_DIR=~/dotfiles/scripts/setup

# スクリプトに実行権限を付与し、実行後に元の権限に戻す関数
run_script_with_original_permissions() {
    local script_path="$1"

    # 元の権限を保存
    local previous_permissions=$(stat -f %A "$script_path")

    # 実行権限を付与
    chmod +x "$script_path"

    # スクリプトを実行
    "$script_path"

    # 実行権限を剥奪
    chmod -x "$script_path"
}

# Zsh の設定を再読み込みする関数. source ./initialize.sh で呼び出さないと、反映されないので注意
reload_zsh_settings() {
    source ~/.zshrc
    source ~/.zshenv
    echo "✅ Reloaded Zsh settings."
}

# ---
# 実行権限を付与して、スクリプトを実行。実行後に元の権限に戻す
# ---
main() {
    # ----
    # for brew packages and apps
    # ----
    run_script_with_original_permissions $SCRIPT_SETUP_DIR/install-brew-packages-and-apps.sh

    # ----
    # for zsh settings
    # ----
    run_script_with_original_permissions $SCRIPT_SETUP_DIR/setup-zsh.sh
    reload_zsh_settings
}

main
