#!/bin/zsh

# シンボリックリンクを作成する関数
create_symlink() {
    local source="$1"
    local destination="$2"

    echo "💪 Creating symlink: $destination -> $source"
    ln -nfs "$source" "$destination"
    echo "✅ Created symlink: $destination -> $source"
}
