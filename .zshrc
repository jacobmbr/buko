# Path to your oh-my-zsh installation.
export ZSH=$HOME/dotfiles/oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DEFAULT_USER=jacob
export PYTHONSTARTUP=$HOME/.pythonrc.py

# ZSH
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z zsh-syntax-highlighting)

# User configuration

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:$HOME/.npm/bin:$HOME/.local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
export NODE_PATH=$NODE_PATH:/home/jacob/.npm/lib/node_modules:/Users/Jacob/.npm

#### From GRB's dotfile
# Nicer History
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# use vim
export EDITOR=vi

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

#alias ls='ls -G'
#alias ll='ls -lG'
#export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
#export GREP_OPTIONS="--color"
alias grep="grep --color=auto"

# Aliases
alias v="vim"
alias vi="vim"
alias c="clear"
alias gd="git diff"
alias cl="clear"
alias gs="git status"
alias diff="icdiff"

# Make alt-arrow skip words
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

export PATH="/home/jacob/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Fix Openssl version after `brew install openssl`
PATH="/usr/local/opt/openssl/bin:$PATH"

# Haskell Aliases
alias si="time stack install --ghc-options '-O0 -j +RTS -A128m -n2m -s -RTS'"
alias st="time stack test --ghc-options '-O0 -j +RTS -A128m -n2m -s -RTS'"

# GPG Agent
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Gcloud SDK
if [ -f '/home/jacob/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jacob/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/home/jacob/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jacob/google-cloud-sdk/completion.zsh.inc'; fi
#
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Kubectl completion
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

source ~/dotfiles/sga-env.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jacob/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jacob/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jacob/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jacob/google-cloud-sdk/completion.zsh.inc'; fi


eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
