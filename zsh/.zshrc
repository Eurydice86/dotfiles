# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nikos/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(thefuck --alias)"

export EDITOR=emacs

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/nikos/projects/ehms_mc_api/google-cloud-sdk/path.zsh.inc' ]; then . '/home/nikos/projects/ehms_mc_api/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/nikos/projects/ehms_mc_api/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/nikos/projects/ehms_mc_api/google-cloud-sdk/completion.zsh.inc'; fi
