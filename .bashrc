# Load aliases
[ -f "${HOME}/.shell_conf/.alias" ] && source "${HOME}/.shell_conf/.alias"
[ -f "${HOME}/.shell_conf/.paths" ] && source "${HOME}/.shell_conf/.paths"

export EDITOR='nvim'

[ -f "${HOME}/.ssh/.env" ] && source "${HOME}/.ssh/.env"

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
