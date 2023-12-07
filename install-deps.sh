#!/usr/bin/env sh

set -e

# Alpine
if type apk > /dev/null; then
    apk update
    apk upgrade
    apk add zsh git bash tmux wget tar neovim clang-extra-tools
# RHEL
elif type yum > /dev/null; then
    yum -y update
    yum -y install zsh git bash wget tar clang-tools-extra
    yum -y install http://galaxy4.net/repo/galaxy4-release-8-current.noarch.rpm
    yum -y install tmux
    # In RHEL package reporsitories, some python dependencies are missing,
    # so taking the appimage instead.
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage

    # Needed as if we run the image directly, it might complain about fuse
    # being not available.
    ./nvim.appimage --appimage-extract

    # Make it available globally and remove the appimage.
    ln -s /squashfs-root/AppRun /usr/bin/nvim
    rm nvim.appimage
# Arch
elif type pacman > /dev/null; then
    pacman -Sy
    pacman -S zsh git bash tmux wget tar neovim clang
# Debian / Ubuntu
elif type apt-get > /dev/null; then
    apt-get update
    apt-get -y upgrade
    apt-get -y install zsh git bash tmux wget tar clangd curl

    # In Debian / Ubuntu package reporsitories, the neovim package is too old,
    # so taking the appimage instead.
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage

    # Needed as if we run the image directly, it might complain about fuse
    # being not available.
    ./nvim.appimage --appimage-extract

    # Make it available globally and remove the appimage.
    ln -s /squashfs-root/AppRun /usr/bin/nvim
    rm nvim.appimage
fi
