# ~/.zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ "$TMUX" = "" ]; then tmux; fi


# Options
setopt prompt_subst
setopt auto_list
setopt hist_find_no_dups
setopt hist_ignore_dups


# Auto startx
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	startx
fi

# Vars
export TERMINAL="kitty"
export BROWSER="firefox"
export EDITOR="nvim"
export VISUAL="${EDITOR}"
export HELIX_RUNTIME=~/src/helix/runtime


# Aliases
alias pls='sudo'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias cl='clear'
alias cp="cp -i"
alias df='df -h'
alias free='free -m'

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# cute sudo
export SUDO_PROMPT="sudo password please: "

# not found
command_not_found_handler() {
	printf "%s%s? I don't know what is it\n" "$acc" "$0" >&2
    return 127
}

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/dung/go/bin/gopls:/home/dung/Downloads/lua-language-server/bin
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/Downloads/yaml-language-server/out/server/src:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
