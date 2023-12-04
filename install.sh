#/usr/bin/env zsh

require() {
    ret=0
    for i; do
        if ! type $i > /dev/null; then
            echo "Missing requirement: $i"
            ret=1
        fi
    done
    return $ret
}

require git bash tmux zsh wget tar
if [ $? -ne 0 ]; then
    echo "Cannot proceed further, exiting"
    exit 1
fi

# Prompt the user
echo "WARNING: By continuing, this might override some existing configs."
echo "Please type 'continue' to proceed or 'abort' to exit the script."

# Read user input
read -p "Enter your choice: " user_choice

install() {
    SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
    cp ${SCRIPT_DIR}/.zshrc ${HOME}/.zshrc
    mkdir -p ${HOME}/.config/tmux
    cp ${SCRIPT_DIR}/.config/tmux/tmux.conf ${HOME}/.config/tmux
    if test ! -d ~/.tmux/plugins/tpm; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&\
            ~/.tmux/plugins/tpm/bin/install_plugins
    fi
    cp -R ${SCRIPT_DIR}/.config/nvim ${HOME}/.config/nvim
    cp -R ${SCRIPT_DIR}/.config/alacritty ${HOME}/.config/alacritty
    echo "Done"
}

# Check user input
case $user_choice in
    [cC][oO][nN][tT][iI][nN][uU][eE])
        echo "Proceeding with the install..."
        install
        ;;
    [aA][bB][oO][rR][tT])
        echo "Aborting"
        exit 0
        ;;
    *)
        echo "Invalid input. Please run the script again and enter 'continue' or 'abort'."
        exit 1
        ;;
esac
