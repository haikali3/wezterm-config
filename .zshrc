# =============================================================================
# ZSH Configuration File
# =============================================================================
# This file contains your personal ZSH configuration. It's loaded when you start
# a new terminal session. The configuration includes:
# - Powerlevel10k theme
# - Zinit plugin manager
# - Custom abbreviations
# - Vim keybindings
# =============================================================================

# -----------------------------------------------------------------------------
# Powerlevel10k Instant Prompt
# -----------------------------------------------------------------------------
# This enables instant prompt for Powerlevel10k theme, which makes the prompt
# appear immediately while the rest of the configuration loads in the background.
# This should stay at the top of the file.
# -----------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------------
# PostgreSQL PATH exports
# -----------------------------------------------------------------------------
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# -----------------------------------------------------------------------------
# Go PATH exports
# -----------------------------------------------------------------------------
export PATH=$PATH:$(go env GOPATH)/bin

# Whether to add default bindings (expand on SPACE, expand and accept on ENTER,
# add CTRL for normal SPACE/ENTER; in incremental search mode expand on CTRL+SPACE)
# (default true)
# typeset -gi ABBR_DEFAULT_BINDINGS=${ABBR_DEFAULT_BINDINGS:-1}

# -----------------------------------------------------------------------------
# Zinit Plugin Manager Installation
# -----------------------------------------------------------------------------
# Zinit is a flexible and fast ZSH plugin manager. This section handles its
# installation if it's not already present.
# -----------------------------------------------------------------------------
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# Load Zinit
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Enable Zsh completion system
# -----------------------------------------------------------------------------
autoload -Uz compinit
compinit

# -----------------------------------------------------------------------------
# Zinit Annexes
# -----------------------------------------------------------------------------
# These are essential Zinit components that provide additional functionality:
# - as-monitor: Monitors plugin loading
# - bin-gem-node: Handles binary, gem, and node packages
# - patch-dl: Handles downloading and patching
# - rust: Provides Rust-specific functionality
# -----------------------------------------------------------------------------
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# -----------------------------------------------------------------------------
# Theme and Plugins
# -----------------------------------------------------------------------------
# Load various plugins and themes:
# - Powerlevel10k: A highly customizable theme
# - zsh-autosuggestions: Suggests commands as you type
# - zsh-syntax-highlighting: Highlights commands while typing
# - zsh-abbr: Manages command abbreviations
# -----------------------------------------------------------------------------

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# Load zsh-autosuggestions plugin
zinit light zsh-users/zsh-autosuggestions

# Load zsh-syntax-highlighting plugin
zinit light zsh-users/zsh-syntax-highlighting

# Load the abbr plugin (synchronously)
zinit ice lucid
zinit light olets/zsh-abbr

# -----------------------------------------------------------------------------
# Docker & Compose auto-completion via Zinit
# -----------------------------------------------------------------------------
# Docker CLI completions
zinit ice from"gh"   as"program" src"contrib/completion/zsh/_docker"
zinit light docker/cli

# docker-compose completions
# zinit ice from"gh"   as"program" src"contrib/completion/zsh/_docker-compose"
# zinit light docker/cli

# -----------------------------------------------------------------------------
# Docker & Compose auto-completion via Zinit
# -----------------------------------------------------------------------------
# Docker CLI completions
# zinit ice from"gh" as"completion" pick"contrib/completion/zsh/_docker"
# zinit load docker/cli

# docker-compose completions
zinit ice from"gh" as"completion" pick"contrib/completion/zsh/_docker-compose"
zinit load docker/cli

# Re-bind space to self-insert so abbr can hook it
# zle -N self-insert _zsh_abbr_self_insert
# bindkey ' ' self-insert

# -----------------------------------------------------------------------------
# Abbreviations Configuration
# -----------------------------------------------------------------------------
# This section manages command abbreviations. Abbreviations are shortcuts that
# expand to full commands when you type them followed by a space.
# -----------------------------------------------------------------------------

# run `abbr list` to see all abbreviations
# run `abbr erase` to erase all abbreviations
# run `abbr add -U <alias> <command>` to add an abbreviation

# Git abbreviations
# abbr add -U g='git '                    # Basic git command
# abbr add -U gp='git pull '              # Git pull
# abbr add -U gpush='git push'
# abbr add -U gpushup='git push --set-upstream origin ' # insert branch name
# abbr add -U gb='git branch'
# abbr add -U gs='git status'
# abbr add -U gc='git checkout'           # Git checkout
# abbr add -U gcb='git checkout -b '      # Create and checkout new branch
# abbr add -U gcgp='git checkout main && git pull '  # Switch to main and pull
# abbr add -U gcm='git commit -m '        # Git commit with message


# PNPM abbreviations
# abbr add -U p='pnpm '
# abbr add -U pi='pnpm install '          # Install dependencies
# abbr add -U pid='pnpm install && pnpm dev '     # Install dev dependencies
# abbr add -U pd='pnpm dev '              # Run dev server
# abbr add -U pb='pnpm build'

# Bun abbreviations
# abbr add -U b='bun '
# abbr add -U bi='bun install '
# abbr add -U bid='bun install && bun dev'
# abbr add -U bd='bun dev '
# abbr add -U bb='bun build '


# Utility abbreviations
# abbr add -U cl='clear'                  # Clear screen
# abbr add -U csr='cursor'                # Open Cursor IDE

# Python abbreviations
# abbr add -U pyt='python3 '               # Python3 command
# abbr add -U pip='pip3 '                  # Pip3 command


# -----------------------------------------------------------------------------
# Aliases Configuration
# -----------------------------------------------------------------------------
# This section contains command aliases for frequently used commands
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Powerlevel10k Configuration
# -----------------------------------------------------------------------------
# Load Powerlevel10k configuration if it exists
# Run 'p10k configure' to customize the prompt
# -----------------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -----------------------------------------------------------------------------
# Vim Mode Configuration
# -----------------------------------------------------------------------------
# This section configures Vim-like keybindings in ZSH:
# - Enable Vim mode
# - Show current mode in right prompt
# - Map 'jk' to escape in insert mode
# -----------------------------------------------------------------------------

# Enable Vim (vi) mode in Zsh
bindkey -v

# Show current mode in right prompt
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    # Normal mode: block cursor
    echo -ne '\e[2 q'
    RPROMPT="-- NORMAL --"
  elif [[ $KEYMAP == main ]]; then
    # Visual mode: underline cursor
    echo -ne '\e[4 q'
    RPROMPT="-- VISUAL --"
  else
    # Insert mode: beam cursor
    echo -ne '\e[6 q'
    RPROMPT=""
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

zle-line-init() { zle-keymap-select }
zle -N zle-line-init

# Map 'jk' in insert mode to escape to normal mode (like Vim)
function vi-jk-escape() {
  if [[ $KEYS == 'jk' ]]; then
    zle vi-cmd-mode
  else
    zle self-insert
  fi
}
zle -N vi-jk-escape

bindkey -M viins 'jk' vi-jk-escape
# bun completions
[ -s "/Users/haikaltahar/.bun/_bun" ] && source "/Users/haikaltahar/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

