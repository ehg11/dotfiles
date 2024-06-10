# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

[ -f "/home/hwang/.ghcup/env" ] && source "/home/hwang/.ghcup/env" # ghcup-env

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hwang/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hwang/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hwang/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hwang/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> juliaup initialize >>>
# !! Contents within this block are managed by juliaup !!

path=('/home/hwang/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# >>> NVM Setup >>>
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# <<< NVM Setup End <<<

export PATH=$PATH:/usr/local/go/bin:/home/hwang/.scripts:/home/hwang/.docker/cli-plugins/
eval "$(zoxide init zsh)"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.toml)"

alias ls='exa'
alias ll='exa -alh'
alias grep='grep --color=auto'
alias ls='exa --color=always --icons --sort=Ext --group-directories-first'
alias ll='exa --color=always --icons --sort=Ext --group-directories-first --long'
alias la='exa --color=always --icons --sort=Ext --group-directories-first --long --all'
alias l.='exa --color=always --icons --sort=Ext --group-directories-first --long --list-dirs .*'
alias python='python3'
alias cdhome='z /mnt/c/Users/hwang'
alias cducla='z /mnt/c/Users/hwang/Desktop/UCLA/Sp24/'
alias cat='batcat'
alias cd='z'
alias cpd='z -'
alias ed='z' # i suck, i know
alias lg='lazygit'
alias nv='nvim'
alias explorer='/mnt/c/Windows/explorer.exe'

bindkey -s '^t' "\nTMUXDIR=\$(pwd) && tmux-sessionizer \$TMUXDIR\n"
bindkey -s '^[t' "\ntmux-sessionizer\n"
bindkey -s '^f' "\n__zoxide_zi\n"
bindkey '^e' autosuggest-accept

# case insensitive completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# history search up and down
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end

# cs130
export USER=hwangedward8
export DOCKER_HOST=unix:///var/run/docker.sock

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/hwang/google-cloud-sdk/path.zsh.inc' ]; then . '/home/hwang/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/hwang/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/hwang/google-cloud-sdk/completion.zsh.inc'; fi

eval $(thefuck --alias fuck)

# easier path to windows home
export WINHOME=/mnt/c/Users/hwang/
export PATH="/mnt/c/Program Files/:$PATH"

# neovim
export PATH="$PATH:/home/hwang/.local/bin/nvim-linux64/bin"
