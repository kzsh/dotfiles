# git aliases (completion is handled in git-completion)
alias gcm='git checkout master'
alias gco='git checkout'
alias gb='git branch'
alias gl='git pull'

# cd to top level of the current git repo
alias git_root='git rev-parse --show-toplevel'
alias cdg='cd $(git_root)'

# color output
alias ls='ls -G'

alias ll='ls -al'
alias l='ls -l'


# open current dir in Finder
alias oo='open -a Finder ./'
alias aa='open -a'
alias chrome='open -a Google\ Chrome'

# Ruby
alias be="bundle exec"

# Keep convenient command but use rg
alias ag="rg --colors 'match:fg:red' --colors 'path:fg:yellow' --colors 'line:fg:yellow'"

# use neovim
alias vi="nvim"
alias vim="nvim"

alias vir="nvim -S \$VIM_DIR/.vimsession.vim"
alias vimr="nvim -S \$VIM_DIR/.vimsession.vim"

alias viinit="nvim \$VIM_DIR/init.vim"
alias viminit="viinit"

# edit all modified files in and out of the index
vimm() {
  nvim -- "$(git st --porcelain | awk '{ print \$2}')"
}

alias todo='CURR=`pwd`; cd ~/TODO && vim TODO.md; cd $CURR'

# Brightness control
if [ -f /usr/local/bin/screen-backlight ]; then
  alias sb="sudo /usr/local/bin/screen-backlight"
fi

if [ -f /usr/local/bin/keyboard-backlight ]; then
  alias kb="sudo /usr/local/bin/keyboard-backlight"
fi

# Docker
alias dm='docker-machine'
alias dc='docker-compose'
