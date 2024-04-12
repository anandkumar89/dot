# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/anand.kumar/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/anand.kumar/.config/zsh/plugins/fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/anand.kumar/.config/zsh/plugins/fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/anand.kumar/.config/zsh/plugins/fzf/shell/key-bindings.zsh"
