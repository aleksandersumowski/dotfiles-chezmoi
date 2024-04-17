# Setup fzf
# ---------
if [[ $OSTYPE == darwin* && $CPUTYPE == arm64 ]]; then
    export FZF_PREFIX="/opt/homebrew/opt/fzf"
else
    export FZF_PREFIX="/usr/local/opt/fzf"
fi

if [[ ! "$PATH" == *$FZF_PREFIX/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$FZF_PREFIX/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_PREFIX/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF_PREFIX/shell/key-bindings.zsh"
