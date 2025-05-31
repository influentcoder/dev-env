Install packages:

```bash
apt install git podman vim zsh
```

Setup the SSH keys in `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`.

Setup the GPG keys.

Clone this repo in `${HOME}`:

```bash
cd ~
git clone git@github.com:influentcoder/dev-env.git 
```

Run a container, name it `dev-container` and follow the steps to compile Alacritty: https://github.com/alacritty/alacritty/blob/master/INSTALL.md

Then copy the `alacritty` binary to `~/.local/bin`, and the icon to `~/.local/share/icons/hicolor/64x64/apps/alacritty-term.png`

In the container, download an unzip the font:

```bash
mkdir /workspace  && cd /workspace
curl -sLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
```

On the host:

```bash
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
podman cp dev-container:/workspace/Hack.zip .
unzip Hack.zip '*.ttf'
fc-cache -fv
rm Hack.zip
```

Create symlinks:

```bash
ln -s ~/dev-env/.config/alacritty ~/.config/alacritty
ln -s ~/dev-env/alacritty.desktop ~/.local/share/applications/alacritty.desktop
ln -s ~/dev-env/.config/gdb ~/.config/gdb
mkdir -p ~/.local/share/tmux/plugins && git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
ln -s ~/dev-env/.zshrc ~/.zshrc
```

Plugins for zsh:

```bash
mkdir -p ~/.config/zsh
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/zsh-syntax-highlighting
```

## Citrix Workspace

Download the tarball from here: https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html

Follow the installation steps: https://docs.citrix.com/en-us/citrix-workspace-app-for-linux/installation

No need for GStreamer plugin, deviceTrust, USB support.

Everything should be installed in `~/ICAClient`.

As of this writing, things like alt-tab don't work with Wayland, alt-tab will go out of Citrix, even in full screen.
Check if using wayland: `echo $XDG_SESSION_TYPE`

In Debian 12, there is no option to choose for X11 or Wayland on the login screen, so we have to force enable X11 permanently.

Edit `/etc/gdm3/daemon.conf` and make sure that `WaylandEnable=false`.

Then run `sudo systemctl restart gdm` (this will logout). If still not working, try to reboot.

## Zoom

Just use the webapp: https://app.zoom.us/wc/

For now, no easy be to do a rootless install.

## Tmux

In one terminal:

```bash
podman run -it --rm --name tmux_build docker.io/library/debian:bookworm-slim /bin/bash

mkdir workspace && cd workspace
apt-get update
apt-get install -y curl libevent-dev ncurses-dev build-essential bison pkg-config

curl -sLO https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz
tar xzf tmux-3.5a.tar.gz
cd tmux-3.5a
./configure --enable-static
make
```

Don't exit the container - and in another terminal:

```bash
podman cp tmux_build:/workspace/tmux-3.5a/tmux ~/.local/bin/
```

You can now exit the container.

Install tpm:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```
