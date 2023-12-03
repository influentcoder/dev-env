# History settings.
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Disable beep sounds on error, such as when there are no completion results.
unsetopt beep

# Set the viins keymap (vi emulation - insert mode).
# See: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
zstyle ':completion:::*:default' menu no select
# End of lines added by compinstall

# Provide color to ls output, e.g. to highlight directories.
alias ls="ls --color=auto"

# %n => $USERNAME
# %m => hostname
# %~ => cwd
# See: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
PROMPT='%F{cyan}%n%f@%F{green}%m:%F{yellow}%~%f $ '

# PATH settings.
PATH="${HOME}/bin/nvim/bin:${PATH}"
PATH="${HOME}/bin/clangd_17.0.3/bin:${PATH}"

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

ZSH_SYNT_HLT_INSTALLED=0
if [ ! -d ${HOME}/.config/zsh/zsh-syntax-highlighting-master ]; then
    echo "Plugin zsh-syntax-highlighting-master not found... installing"
    require tar wget
    if [ $? -eq 0 ]; then
        mkdir -p ${HOME}/.config/zsh
        URL=https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz 
        wget ${URL} -O - | tar -xzf - -C ${HOME}/.config/zsh
        ZSH_SYNT_HLT_INSTALLED=1
        echo "Plugin installed"
    else
        echo "Cannot install zsh-syntax-highlighting-master"
    fi
fi

# Needs to be at the bottom!
# See: https://github.com/zsh-users/zsh-syntax-highlighting
if [ $ZSH_SYNT_HLT_INSTALLED -eq 1 ]; then
    source ${HOME}/.config/zsh/zsh-syntax-highlighting-master/zsh-syntax-highlighting.zsh
fi
