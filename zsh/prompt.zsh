# zsh/prompt.zsh
#
# prompt-*.zsh should be loaded first
# Use add-zsh-hook for precmd or else the other ZSH prompt plugins may break
#

# Actual prompt (single line prompt)
__prompt() {
  PS1=''

  # Time
  #PS1+='%f'

  PS1+='%{$reset_color%}'

  # Continuation mode
  PS2="$PS1"
  PS2+='%F{green}.%f '

  # Symbol on PS1 only - NOT on PS2 though
  PS1+='%F{yellow}%~%f%{$reset_color%}'

  PS1+='%{$reset_color%}'

  # VCS
  PS1+=' ${vcs_info_msg_0_}'

  PS1+='%F{white}:%f %{$reset_color%}'

  # Exit code if non-zero
  RPROMPT='%F{red}%(?..[%?])'
}

__prompt