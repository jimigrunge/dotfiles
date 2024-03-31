source "${HOME}/.alias"

export EDITOR='nvim'

[ -f "$HOME/.ssh/.env" ] && source "$HOME/.ssh/.env"

export PATH="/Users/jgrundner/Library/Python/2.7/bin:${PATH}"
export PATH="/usr/local/opt/curl/bin:${PATH}"
export PATH="/usr/local/sbin:${PATH}"
export PATH="/usr/local/opt/unzip/bin:${PATH}"
export PATH="${HOME}/.composer/vendor/bin:${PATH}"
export PATH="${HOME}/.composer/tools:${PATH}"
export PATH="${HOME}/.npm/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/.local/bin/bin:${PATH}"
export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${HOME}/bin:${PATH}"

export LDFLAGS="-L/usr/local/opt/curl/lib"
export CPPFLAGS="-I/usr/local/opt/curl/include"

export DELTA_FEATURES='+side-by-side line-numbers navigate decorations'
export OPENAI_API_KEY=""

[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"

eval "$(perl -I"${HOME}"/perl5/lib/perl5 -Mlocal::lib="${HOME}"/perl5)"

export N_PREFIX=$HOME/.local/bin
export EXA_COLORS="da=1;36"

# don't put duplicate lines or lines begining with space in history
# See bash(1) for more options
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%Y-%m-%d %T "

eval "$(mcfly init bash)"
eval "$(atuin init bash)"
