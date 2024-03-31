# Load aliases
[ -f "${HOME}/.shell_conf/.alias" ] && source "{$HOME}/.shell_conf/.alias"
[ -f "${HOME}/.shell_conf/.paths" ] && source "${HOME}/.shell_conf/.paths"

ZSH_DISABLE_COMPFIX='true'

export EDITOR='nvim'

[ -f "$HOME/.ssh/.env" ] && source "$HOME/.ssh/.env"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="jimigrunge"

# how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( dircycle zsh-autosuggestions zsh-syntax-highlighting web-search )

# Initialize Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# C flags
export LDFLAGS="-L/usr/local/opt/curl/lib"
export CPPFLAGS="-I/usr/local/opt/curl/include"

# Delta diff options
export DELTA_FEATURES='+side-by-side line-numbers navigate decorations'
export OPENAI_API_KEY=""

# Fuzzy finder
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# Perl
[ -d $HOME/perl5 ] && eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# EXA configuration
export N_PREFIX=$HOME/.local/bin
export EXA_COLORS="da=1;36"

# don't put duplicate lines or lines begining with space in history
# See bash(1) for more options
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%Y-%m-%d %T "

# McFly Ctrl+r history search
eval "$(mcfly init zsh)"
# Atuin Ctrl+r hstory search
# eval "$(atuin init zsh)"

if [[ -f '/Users/jgrundner/opt/anaconda3/bin/conda' ]];then
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
fi
