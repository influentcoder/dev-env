#/usr/bin/env zsh

# Prompt the user
echo "WARNING: By continuing, this might override some existing configs."
echo "Please type 'continue' to proceed or 'abort' to exit the script."

# Read user input
read -p "Enter your choice: " user_choice

install() {
    SCRIPT_DIR=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
    cp ${SCRIPT_DIR}/.zshrc ${HOME}/.zshrc
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
