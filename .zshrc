#export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gallois"
plugins=(git)

#source $ZSH/oh-my-zsh.sh
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTTIMEFORMAT="[%F %T] "
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

autoload -U +X bashcompinit && bashcompinit
autoload -U compinit && compinit

### direnv:
eval "$(direnv hook zsh)"
### end direnv
#

### gcloud:
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
### env gcloud
export CLOUDSDK_PYTHON_SITEPACKAGES=1

export PATH="$HOME/bin:$PATH:$HOME/go/bin:/usr/local/sbin"

alias mtrr="sudo mtr -T -P 443 -e -z "

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/mico/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
export NIXPKGS_ALLOW_UNFREE=1

#eval "$(zellij setup --generate-completion zsh)"

eval "$(zoxide init zsh)"
alias cd="z"

alias nvvim="NVIM_APPNAME=nvim-nvchad nvim"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
compdef git config

#eval "$(starship init zsh)"
eval "$(oh-my-posh init zsh --config ~/tools/oh-my-posh/themes/gruvbox.omp.json)"

export EDITOR=nvim
