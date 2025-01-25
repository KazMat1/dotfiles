#!/bin/zsh

# バックアップディレクトリを作成する関数
create_backup_dir() {
    local backup_dir="$1"

    if [ ! -d "$backup_dir" ]; then
        echo "💪 Creating backup directory at $backup_dir"
        mkdir -p "$backup_dir"
        echo "✅ Created backup directory at $backup_dir"
    else 
        echo "👋 Backup directory already exists at $backup_dir. skip creating the backup directory"
    fi
}

# 既存のファイルをバックアップディレクトリに移動する関数
mv_existing_file_to_backup_dir() {
    local destination="$1"
    local backup_dir="$2"

    if [ -e "$destination" ]; then
        if [ ! -L "$destination" ]; then
            echo "😲 $destination is not a symlink but already exists. so moving to backup directory..."
            echo "💪 moving $destination to $backup_dir"
            mv "$destination" "$backup_dir"
            echo "✅ moved $destination to $backup_dir"
        else
            echo "👋 $destination is a symlink, so ignore backup process"
        fi
    fi
}