# ============================================================================
# Dotfile paths
# ============================================================================
export DOTFILES_DIRECTORY="${HOME}/.dotfiles"
export LOCAL_CONFIG_DIRECTORY="${DOTFILES_DIRECTORY}/local"
export ZSH_CONFIG_DIRECTORY="${DOTFILES_DIRECTORY}/zsh"
export ZDOTDIR="${ZSH_CONFIG_DIRECTORY}"

# ----------------------------------------------------------------------------
# zsh-nvm
# ----------------------------------------------------------------------------

# Tell zsh-nvm to auto switch node versions based on a `.nvmrc` file in the
# target directory
export NVM_AUTO_USE=true