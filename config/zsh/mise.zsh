## mise (https://mise.jdx.dev/getting-started.html)
# brew install mise
### if you use a zsh, run a below command and then mark as a last line
write_executable_path_to_zshrc() {
    echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
}

# --------------------
# mise
# --------------------
# write_executable_path_to_zshrc
# 上記を実行すると以下が出力される
eval "$(mise activate zsh)"
