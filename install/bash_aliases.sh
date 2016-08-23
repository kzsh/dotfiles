[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# git aliases (completion is handled in git-completion)
alias gcm='git checkout master'
alias gco='git checkout'
alias gb='git branch'
alias gl='git pull'

# color output
alias ls='ls -G'

alias ll='ls -al'
alias l='ls -l'


#open current dir in Finder
alias oo='open -a Finder ./'

alias aa='open -a'

#cd to top level of the current git repo
alias cdg='cd $(git rev-parse --show-toplevel)'

alias ghb='hub browse'

alias be="bundle exec"

# use neovim
alias vi="nvim"
alias vim="nvim"

