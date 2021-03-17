# git aliases (completion is handled in git-completion)

alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gco='git checkout'
alias gb='git branch'

__git_complete gco _git_checkout
__git_complete gb _git_branch

# cd to top level of the current git repo
alias git_root='git rev-parse --show-toplevel'
alias cdg='cd $(git_root)'

# color output
alias ls='ls -G'

alias ll='ls -al'
alias l='ls -l'

# open current dir in Finder
alias aa='open -a'
alias chrome='open -a Google\ Chrome'
alias firefox='open -a Firefox\ Developer\ Edition.app'
alias dcc='docker-compose'

complete -F _docker_compose dcc
alias kcl='kubectl'
alias kcx='kubectx'
alias kns='kubens'

complete -F __start_kubectl kcl
complete -F __start_kubectx kcx
complete -F __start_kubens kns

alias rg="rg --colors path:fg:red --colors line:style:bold"

alias fd="fd -H --glob" 

alias f="ag --files -g "

# Keep convenient command but use rg
alias ag="rg --colors path:fg:red --colors line:style:bold"


# use neovim
alias vi="nvim"
alias vim="nvim"


# Allow vi-mode bindings for node repl
if [ $(command -v rlwrap) ] ; then
  alias node='NODE_NO_READLINE=1 rlwrap node';
fi

# edit all modified files in and out of the index
vimm() {
  nvim -- "$(git st --porcelain | awk '{ print $2}')"
}

alias todo='CURR=`pwd` && cd ~/TODO && vim TODO.md; cd $CURR'

# Brightness control
if [ -f /usr/local/bin/screen-backlight ]; then
  alias sb="sudo /usr/local/bin/screen-backlight"
fi

if [ -f /usr/local/bin/keyboard-backlight ]; then
  alias kb="sudo /usr/local/bin/keyboard-backlight"
fi
