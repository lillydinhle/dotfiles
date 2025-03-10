# .zshrc

source "${HOME}/.dotfiles/shell/vars.sh"
source "${HOME}/.dotfiles/shell/helpers.sh"

# ============================================================================
# Options
# In the order of `man zshoptions`
# ============================================================================

# Completion
setopt AUTO_LIST                      # list completions
setopt AUTO_MENU                      # double tab to start a tab complete menu

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
export HISTORY_IGNORE="(pwd|l|ls|ll|cl|clear)"

# Input/Output
setopt ALIASES                        # autocomplete switches for aliases
setopt AUTO_PARAM_SLASH               # append slash if autocompleting a dir
setopt CORRECT                        # try to correct spelling of commands

# Prompting
setopt PROMPT_SUBST                   # allow variables in prompt

# Shell Emulation
setopt INTERACTIVE_COMMENTS           # allow comments in shell

# Zle
setopt NO_BEEP

# ============================================================================
# Completion settings
# Order by * specificity
# ============================================================================

# --------------------------------------------------------------------------
# Completion: Caching
# --------------------------------------------------------------------------

zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/.zcache"

# --------------------------------------------------------------------------
# Completion: Display
# --------------------------------------------------------------------------

# Group all by the description above
zstyle ':completion:*' group-name ''

# Updated to respect LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Directories appear before files
zstyle ':completion:*' list-dirs-first yes

# Go into menu mode on second tab
zstyle ':completion:*' menu select=2

# Show descriptions for options
zstyle ':completion:*' verbose yes

# Specify completion types in bold
zstyle ':completion:*:descriptions' format '%F{black}%B%d%b%f'

# --------------------------------------------------------------------------
# Completion: Matching
# --------------------------------------------------------------------------

# Use case-insensitive completion if case-sensitive generated no hits
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}

# --------------------------------------------------------------------------
# Completion: Output transformation
# --------------------------------------------------------------------------

# Expand completions as much as possible on tab
zstyle ':completion:*' expand yes

# ============================================================================
# Modules
# ============================================================================

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# Must be after sourcing zplugin and before cdreplay
autoload -Uz compinit
compinit -i

# Enable menu selection
zmodload -i zsh/complist

# ============================================================================
# Prompt & Title
# @uses vcs_info
# @uses add-zsh-hook
# ============================================================================

source "${ZSH_CONFIG_DIRECTORY}/prompt-vcs.zsh"
source "${ZSH_CONFIG_DIRECTORY}/prompt.zsh"

# ----------------------------------------------------------------------------
# Keybindings - Completion with tab
# Cancel and reset prompt with ctrl-c
# ----------------------------------------------------------------------------

# Shift-tab to select previous result
bindkey -M menuselect '^[[Z'  reverse-menu-complete

# Fix prompt (and side-effect of exiting menuselect) on ^C
bindkey -M menuselect '^C'    reset-prompt

# ----------------------------------------------------------------------------
# Keybindings: History navigation
# Don't bind in vicmd mode, so I can edit multiline commands properly.
# ----------------------------------------------------------------------------

# Up/Down search history filtered using already entered contents
bindkey '^[[A'  history-search-backward
bindkey '^[[B'  history-search-forward

# PgUp/Dn navigate through history like regular up/down
bindkey '^[[5~' up-history
bindkey '^[[6~' down-history

# ============================================================================
# Homebrew
# ============================================================================

if [[ -r "/opt/homebrew/bin/brew" ]]
then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ============================================================================
# zinit
# ============================================================================

__lilly_has 'git' && {
  declare -A ZINIT
  ZINIT[HOME_DIR]="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"

  # part of zinit's install, found by compaudit
  mkdir -p "${ZINIT[HOME_DIR]}" && chmod g-rwX "${ZINIT[HOME_DIR]}"

  lilly_zinit_dest="${ZINIT[HOME_DIR]}/bin"
  lilly_zinit_script="${lilly_zinit_dest}/zinit.zsh"
  __lilly_source "$lilly_zinit_script" || {
    # install if needed
    command git clone https://github.com/zdharma-continuum/zinit "${lilly_zinit_dest}" &&
      __lilly_source "$lilly_zinit_script"
  }
  unset lilly_zinit_dest
  unset lilly_zinit_script

  __lilly_source "${ZSH_CONFIG_DIRECTORY}/zinit.zsh" && {
    autoload -Uz _zinit && (( ${+_comps} )) && _comps[zinit]=_zinit
    alias unzinit='rm -rf "${ZINIT[HOME_DIR]}"'
  }
}

# ============================================================================
# Local: can add more zplugins here
# ============================================================================
source "${LOCAL_CONFIG_DIRECTORY}/.zshrc"

# ============================================================================
# Aliases
# ============================================================================
source "${DOTFILES_DIRECTORY}/shell/aliases.sh"
