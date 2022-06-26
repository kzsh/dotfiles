# export HISTCONTROL=ignoreboth
export HISTSIZE=100
export HISTFILESIZE=1000000               # big big history
# export HISTIGNORE="&:ls:[bf]g:exit:pwd:clear:mount:umount:[ \t]*:rm -rf"

shopt -s histappend # append to history, don't overwrite it
shopt -s histverify
shopt -s histreedit
