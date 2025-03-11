zplugin light lukechilds/zsh-nvm.git

zinit lucid wait for \
  blockf atpull'zinit creinstall -q .' \
  'zsh-users/zsh-completions'

# don't add wait, messes with zsh-autosuggest
zinit lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" for \
  'zdharma-continuum/fast-syntax-highlighting'