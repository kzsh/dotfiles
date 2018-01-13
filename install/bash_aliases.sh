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

alias vir="nvim -S \$VIM_DIR/.vimsession"
alias vimr="nvim -S \$VIM_DIR/.vimsession"

# edit all modified files in and out of the index
alias vimm="vim -- \$(git st --porcelain | awk '{ print \$2}')"

JOURNAL_ALIAS='vim + "/Users/username/journal/$(date +%Y)/$(date +%Y%m%d).md" -c "execute \"normal! Go$(date +%T)\<CR>========\<CR>\" | startinsert "'
alias journal="\$JOURNAL_ALIAS"
alias jj="\$JOURNAL_ALIAS"

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
