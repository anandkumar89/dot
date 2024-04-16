export PATH=$HOME/bin:/usr/local/bin:.local/bin:$PATH

export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$XDG_CONFIG_HOME/zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gallois"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh/plugins"

source $ZSH_CUSTOM/oh-my-zsh

function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# read documentation : zsh prompt expansion on sourceforgenet for help/customization
export PS1="%F{red}($(parse_git_branch))%f%F{blue}[%U%C%u/%T]%f%F{red}$%f "


# export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export EDITOR='nvim'

create_gist_and_edit() {
    local filename="$1"
    
    # Step 1: Check if the file is empty
    if [ ! -s "$filename" ]; then
        echo "$filename" > "$filename"
    fi
    
    # Step 3: Create a Gist using filename and description
    local gist_url=$(gh gist create "$filename" -d "$filename" | egrep -o '.*gist.github.com.*')
   	echo gist_url 
    # Step 4: Delete the temporary local file
    rm "$filename"
    
    # Step 5: Open created Gist for editing in terminal
    if [[ -n "$gist_url" ]]; then
        echo "Opening Gist for editing: $gist_url"
        gh gist edit "$gist_url"
    else
        echo "Failed to create Gist."
    fi
}


convert_svg_to_pdf() {
    if [ $# -ne 1 ]; then
        echo "Usage: convert_svg_to_pdf <filename>"
        return 1
    fi
    
    local filename="$1"
    
    inkscape -D -z --file="$filename.svg" --export-pdf="$filename.pdf" --export-latex
}

# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
alias mvim=/Applications/MacVim.app/Contents/MacOS/Vim
alias nvim=/Applications/nvim-macos/bin/nvim
alias mpv=/Applications/mpv.app/Contents/MacOS/mpv
alias obsidian="cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Notes"
alias gs="gh gist"
alias overleaf="cd ~/Library/CloudStorage/Dropbox/Apps/Overleaf/"
alias so="source $ZSH/.zshrc"
# cd ~/Library/CloudStorage/Dropbox/Apps/Overleaf/


[ -f ~/.config/zsh/plugins/fzf/fzf.zsh ] && source ~/.config/zsh/plugins/fzf/fzf.zsh
