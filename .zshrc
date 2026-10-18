# .zshrc - zamhedonia @ 16.10.2026
# ──────────────────────────────────────────────
# Feature toggles (1 = on, 0 = off)
# ──────────────────────────────────────────────
ENABLE_ZINIT=1          # Zinit install + load (required for P10K and PLUGINS)
ENABLE_SAFE=1           # Download the `safe` tool if missing
ENABLE_P10K=1           # Powerlevel10k prompt (needs ZINIT)
ENABLE_PLUGINS=1        # Syntax highlighting, completions, autosuggestions (needs ZINIT)
ENABLE_ALIASES=1        # Main aliases
ENABLE_EZA_LS=1         # Use eza instead of ls
ENABLE_Z_CD=1           # Use zoxide instead of cd
ENABLE_BAT_CAT=1        # Use bat instead of cat
ENABLE_KEYBINDS=1       # Ctrl+Arrow word navigation
ENABLE_HISTORY=1        # History settings
ENABLE_FASTFETCH=1      # Fastfetch greeting on startup
ENABLE_LOCAL_ENV=1      # Source ~/.local/bin/env (+ create it with scripts subfolder)
# ──────────────────────────────────────────────
# Zinit
# ──────────────────────────────────────────────
if (( ENABLE_ZINIT )); then
  # Set the directory we want to store zinit and plugins
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

  # Download Zinit, if it's not there yet
  if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
  fi

  # Source/Load zinit
  source "${ZINIT_HOME}/zinit.zsh"

  # Add in Powerlevel10k
  if (( ENABLE_P10K )); then
    zinit ice depth=1; zinit light romkatv/powerlevel10k
  fi

  # Add in zsh plugins
  if (( ENABLE_PLUGINS )); then
    zinit light zsh-users/zsh-syntax-highlighting
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-autosuggestions
    zinit ice lucid wait'0'
    zinit light joshskidmore/zsh-fzf-history-search
  fi
fi

# ──────────────────────────────────────────────
# safe
# ──────────────────────────────────────────────
if (( ENABLE_SAFE )); then
  # Download safe, if it's not there yet
  if [ ! -f "$HOME/.local/bin/safe" ]; then
    echo "Downloading safe..."
    mkdir -p "$HOME/.local/bin"
    curl https://raw.githubusercontent.com/zamhedonia/safe/refs/heads/master/safe > ~/.local/bin/safe
    chmod +x ~/.local/bin/safe
  fi
fi

# ──────────────────────────────────────────────
# Aliases
# ──────────────────────────────────────────────
if (( ENABLE_ALIASES )); then
  alias grep='grep --color=auto'
  alias neofetch='fastfetch -c neofetch'
  alias bottles='flatpak run com.usebottles.bottles'
  alias inverse-headphones="/home/samu/Programme/Inverse-Headphone.sh"
  alias pythonv="/home/samu/.venv/bin/python3"
  alias pipv="/home/samu/.venv/bin/pip"
  alias rm="safe rm"
  alias hx="helix"
  alias venv="source ~/.venv/bin/activate"
  alias files="yazi"
fi

# ──────────────────────────────────────────────
# Replace ls with eza
# ──────────────────────────────────────────────
if (( ENABLE_EZA_LS )); then
  if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons=always --color=auto'
  fi
fi

# ──────────────────────────────────────────────
# Replace cd with z
# ──────────────────────────────────────────────
if (( ENABLE_Z_CD )); then
  if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    alias cd="z"
  fi
fi

# ──────────────────────────────────────────────
# Replace cat with bat
# ──────────────────────────────────────────────
if (( ENABLE_BAT_CAT )); then
  if command -v bat >/dev/null 2>&1; then
    alias cat="bat --style plain --pager never"
  fi
fi

# ──────────────────────────────────────────────
# Keybinds
# ──────────────────────────────────────────────
if (( ENABLE_KEYBINDS )); then
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
fi

# ──────────────────────────────────────────────
# History
# ──────────────────────────────────────────────
if (( ENABLE_HISTORY )); then
  HISTSIZE=500
  HISTFILE=~/.zsh_history
  SAVEHIST=$HISTSIZE
  HISTDUP=erase
fi

# ──────────────────────────────────────────────
# Powerlevel10k config
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# ──────────────────────────────────────────────
if (( ENABLE_ZINIT && ENABLE_P10K )); then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

# ──────────────────────────────────────────────
# Fastfetch greeting
# ──────────────────────────────────────────────
if (( ENABLE_FASTFETCH )); then
  echo
  fastfetch --logo-type small --separator "  " -s title:break:os:kernel:memory:datetime:battery:break:colors
  echo
fi

# ──────────────────────────────────────────────
# Create ~/.local/bin with scripts folder and env file
# ──────────────────────────────────────────────
if (( ENABLE_LOCAL_ENV )); then
  # Create the folders if they don't exist yet
  mkdir -p "$HOME/.local/bin/scripts"

  # Create the env file if it doesn't exist yet
  if [ ! -f "$HOME/.local/bin/env" ]; then
    cat > "$HOME/.local/bin/env" << 'EOF'
#!/bin/sh
# add binaries to PATH if they aren't added yet
# affix colons on either side of $PATH to simplify matching
for dir in "$HOME/.local/bin" "$HOME/.local/bin/scripts"; do
    case ":${PATH}:" in
        *:"$dir":*)
            ;;
        *)
            # Prepending path in case a system-installed binary needs to be overridden
            export PATH="$dir:$PATH"
            ;;
    esac
done
EOF
  fi

  . "$HOME/.local/bin/env"
fi
