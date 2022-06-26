# git aliases (completion is handled in git-completion)

alias gcm='git checkout master'
alias gco='git checkout'
alias gb='git branch'
alias gcp='git cherry-pick'

__git_complete gco _git_checkout
__git_complete gb _git_branch
__git_complete gcp _git_cherry_pick

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

alias pcl='playerctl'

alias rg="rg --colors path:fg:red --colors line:style:bold"

alias fd="fd -H --glob" 

alias f="ag --files -g "

# Keep convenient command but use rg
alias ag="rg --colors path:fg:red --colors line:style:bold"


# use neovim
alias vi="nvim"
alias vim="nvim"


# if [ -f "$HOME/bin/aws" ]; then
#   alias aws="$HOME/bin/aws"
# fi

# if [ -f "$HOME/bin/aws_completer" ]; then
#   alias aws_completer="$HOME/bin/aws_completer"
# fi

if [ -f "$HOME/bin/yq" ]; then
  alias yq="$HOME/bin/yq"
fi

if [ -f "$HOME/bin/xq" ]; then
  alias yq="$HOME/bin/xq"
fi

# Allow vi-mode bindings for node repl, mongo
if command -v rlwrap > /dev/null 2>&1; then
  alias node='rlwrap --polling --always-readline node';
  alias mongo='rlwrap --polling --always-readline mongo';
fi
