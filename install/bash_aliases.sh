# git aliases (completion is handled in git-completion)
alias gcm='git checkout master'
alias gco='git checkout'
alias gb='git branch'
alias gl='git pull'

# color output
alias ls='ls -G'

alias ll='ls -al'
alias l='ls -l'


# open current dir in Finder
alias oo='open -a Finder ./'
alias aa='open -a'

# cd to top level of the current git repo
alias cdg='cd $(git rev-parse --show-toplevel)'

alias ghb='hub browse'

alias be="bundle exec"

# use neovim
alias vi="nvim"
alias vim="nvim"

alias vir="nvim -S ~/vimsession"
alias vimr="nvim -S ~/vimsession"

JOURNAL_ALIAS='vim + "/Users/username/journal/$(date +%Y)/$(date +%Y%m%d).md" -c "execute \"normal! Go$(date +%T)\<CR>========\<CR>\" | startinsert "'
alias journal="$JOURNAL_ALIAS"
alias jj="$JOURNAL_ALIAS"

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
