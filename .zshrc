# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Create a .local/bin directory
if [ ! -d "$HOME/.local/bin" ]; then
mkdir -p "$HOME/.local/bin"
fi

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Download safe, if it's not there yet
if [ ! -f "$HOME/.local/bin/safe" ]; then
echo "Downloading safe..."
curl https://raw.githubusercontent.com/zamhedonia/safe/refs/heads/master/safe > ~/.local/bin/safe
chmod +x ~/.local/bin/safe
fi

# Write env file
if [ ! -f "$HOME/.local/bin/env" ]; then
cat > "$HOME/.local/bin/env" << 'EOF'
#!/bin/sh
# add binaries to PATH if they aren't added yet
# affix colons on either side of $PATH to simplify matching
case ":${PATH}:" in
    *:"$HOME/.local/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed binary needs to be overridden
        export PATH="$HOME/.local/bin:$PATH"
        ;;
esac
EOF
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Source env
. "$HOME/.local/bin/env"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=always --color=auto'
fi

alias grep='grep --color=auto'
alias neofetch='fastfetch -c neofetch'
alias bottles='flatpak run com.usebottles.bottles'
alias inverse-headphones="$HOME/Programme/Inverse-Headphone.sh"
alias pythonv="$HOME/.venv/bin/python3"
alias pipv="$HOME/.venv/bin/pip"
alias rm="safe rm"
alias hx="helix"

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

HISTSIZE=500
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fastfetch prompt
if command -v fastfetch >/dev/null 2>&1; then
echo 
fastfetch --logo small --separator "  " -s title:break:host:os:terminal:datetime:battery:break:colors
echo
fi
