ZSH_DISABLE_COMPFIX='true'

export EDITOR='nvim'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# BEGIN:  jGrundner specific commands

# Laravel artisan
function artisan() {
    php artisan $*
}

# Laravel homested Vagrant VM
function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

# Docker container shell
function dsh() {
    ( docker exec -it $* )
}

function vessel() {
    ( $(pwd)/vessel $* )
}

function remove-all-docker-images() {
    ( docker rmi $(docker images -a -q) )
}

# END: jGrundner

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jimigrunge"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git ruby gem brew composer coffee dircycle encode64 jsontools node npm osx phing sudo symfony2 urltools vagrant web-search)
#plugins=(git brew composer dircycle encode64 npm osx symfony2 web-search)
plugins=( dircycle zsh-autosuggestions zsh-syntax-highlighting web-search )

source $ZSH/oh-my-zsh.sh
source "$HOME/.ssh/.env"

# User configuration
# /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases

# Load aliases
source $HOME/.alias

export PATH=/Users/jgrundner/Library/Python/2.7/bin:$PATH
export PATH=/usr/local/opt/curl/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH="/usr/local/opt/unzip/bin:$PATH"
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/.npm-global/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/.local/bin/bin:$PATH
export PATH=$HOME/bin:$PATH

export LDFLAGS="-L/usr/local/opt/curl/lib"
export CPPFLAGS="-I/usr/local/opt/curl/include"

export DELTA_FEATURES='+side-by-side line-numbers navigate decorations'
export OPENAI_API_KEY=""

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

export N_PREFIX=$HOME/.local/bin
export EXA_COLORS="da=1;36"

# don't put duplicate lines or lines begining with space in history
# See bash(1) for more options
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%Y-%m-%d %T "

eval "$(mcfly init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jgrundner/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jgrundner/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jgrundner/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jgrundner/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
eval "$(atuin init zsh)"
