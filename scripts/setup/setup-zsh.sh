#!/bin/zsh

# --------
# Description
#
# -z: 文字列が空であるかどうかをチェックします。
# ex: if [ -z "$VAR" ]; then は、VAR が空の文字列である場合に真となります。
#
# -e: ファイルが存在するかどうかをチェックします。
# ex: if [ -e "$FILE" ]; then は、FILE が存在する場合に真となります。
#
# -L: ファイルがシンボリックリンクであるかどうかをチェックします。
# ex: if [ -L "$LINK" ]; then は、LINK がシンボリックリンクである場合に真となります。
# --------

DEFAULT_BACKUP_DIR=~/.backup-zsh

# dotfiles/script/utils を読み込む
source ~/dotfiles/scripts/utils/backup.sh
source ~/dotfiles/scripts/utils/symlink.sh

# 既存のファイルはバックアップディレクトリに移動し、新しいファイルにシンボリックリンクを作成。
backup_existing_file_and_create_symlink() {
    local source="$1"
    local destination="$2"
    local backup_dir="$3"

    mv_existing_file_to_backup_dir "$destination" "$backup_dir"
    create_symlink "$source" "$destination"
}

# メイン処理
main() {

    echo "🚀 Setting up Zsh..."
    echo "Please enter the backup directory path. (default: $DEFAULT_BACKUP_DIR):"
    read -r ZSH_BACKUP_DIR

    if [ -z "$ZSH_BACKUP_DIR" ]; then
        # 入力されていない場合、デフォルトのバックアップディレクトリを使用
        ZSH_BACKUP_DIR="$DEFAULT_BACKUP_DIR"
    fi

    create_backup_dir $ZSH_BACKUP_DIR

    # バックアップとシンボリックリンクの作成
    backup_existing_file_and_create_symlink ~/dotfiles/.zshrc ~/.zshrc $ZSH_BACKUP_DIR
    backup_existing_file_and_create_symlink ~/dotfiles/.zshenv ~/.zshenv $ZSH_BACKUP_DIR
    
    echo "✅ Complete setting up Zsh"
}

main
