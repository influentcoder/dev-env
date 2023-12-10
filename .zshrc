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

if [ -f ${HOME}/.envvars ]; then
    source ${HOME}/.envvars
fi

# Needs to be at the bottom!
# See: https://github.com/zsh-users/zsh-syntax-highlighting
source ${HOME}/.config/zsh/zsh-syntax-highlighting-master/zsh-syntax-highlighting.zsh
