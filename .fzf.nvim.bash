# Setup fzf
# ---------
# if [[ ! "$PATH" == */Users/jgrundner/.local/share/lunarvim/site/pack/packer/start/fzf/bin* ]]; then
if [[ ! "$PATH" == */Users/jgrundner/.local/share/nvim/lazy/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/jgrundner/.local/share/nvim/lazy/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/jgrundner/.local/share/nvim/lazy/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/jgrundner/.local/share/nvim/lazy/fzf/shell/key-bindings.zsh"
