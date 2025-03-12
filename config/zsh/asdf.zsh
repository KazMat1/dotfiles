## asdf
# brew install asdf
### if you use a zsh, run a below command and then mark as a last line
write_executable_path_to_zshrc() {
    echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
}

# --------------------
# asdf
# --------------------
# write_executable_path_to_zshrc
# 上記を実行すると以下が出力される
. /opt/homebrew/opt/asdf/libexec/asdf.sh
