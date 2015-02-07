# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew autojump ant encode64 osx gem github mvn node npm pip python rake rails rbenv rvm rsync urltools heroku bower history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
#source $HOME/.access
source $HOME/.nvm/nvm.sh

unsetopt correct_all
unsetopt correct

# Customize aliases...

#open current dir in Finder
alias oo='open -a Finder ./'
alias aa='open -a'
#alias ctags='/usr/local/bin/ctags'

#cd to top level of the current git repo
alias cdg='cd $(git rev-parse --show-toplevel)'

#shortcuts for custom git-submit and work commands
alias gs="git submit"
alias gw="git work"

alias emacs='/usr/local/Cellar/emacs/24.2/bin/emacs'

#alias it="$HOME/scripts/bash/iTunes.sh"

#ensure that vim is pointing at the right bin
alias vim="/usr/local/bin/vim"
alias vi="/usr/local/bin/vim"

alias lint="java -jar $HOME/.lint/jslint4java.jar"
alias ll="ls -al"
alias qc="~/bin/qc.sh"

alias pserv="python -m SimpleHTTPServer"

# Custom Functions

function gfind {
    grep -r "$1" .
}


#URELEASE SPECIFIC STUFF
source $HOME/projects/urelease/bin/ureleaserc

alias rake='noglob rake'

MAVEN_HOME="$HOME/tools/apache/apache-maven-3.1.0"
ANT_HOME="$HOME/tools/apache/apache-ant-1.8.4"
HEROKU="/usr/local/heroku/bin"
JAVA_HOME="/Library/Java/Home"
JAVA_BIN="$JAVA_HOME/bin"
ECLIPSE_HOME="$HOME/tools/eclipse/eclipse_kepler"
ECLIM_OPTS="-Djava.awt.headless=true"
RUBY_ENV="$HOME/.rbenv/bin"
VIRTUALENV="$HOME/tools/virtualenv-1.7.2"
CATALINA_HOME="$HOME/tools/apache/apache-tomcat-7.0.30"
CATALINA_OPTS="-Xms256m -Xmx4096m -XX:PermSize=512m -XX:MaxPermSize=512m" #-Xmx4000M -XX:MaxPermSize=2048M"
#ANT_OPTS="-Xmx4g -Xms1g"
NPM_BIN="/usr/local/share/npm/bin"
IBM_FIT_DEPLOYER="$HOME/IBM/deployer.cli/bin"
USR_LOCAL_GIT_BIN="/usr/local/git/bin"
HOME_BIN="$HOME/bin"
X11_BIN="/opt/X11/bin"
AUTOJUMP_BIN="$HOME/.autojump/bin"
EC2_HOME="$HOME/tools/amazon/ec2-api-tools-1.6.1.4"
EC2_BIN="$HOME/tools/amazon/ec2-api-tools-1.6.1.4/bin"
ML_BIN="/usr/local/smlnj-110.75/bin"

PATH=$PATH:$HOME/.rvm/gems/ruby-1.9.2-p320/bin:$HOME/.rvm/gems/ruby-1.9.2-p320@global/bin:$HOME/.rvm/rubies/ruby-1.9.2-p320/bin:$HOME/.rvm/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin

PATH=$PATH:$ML_BIN:$JAVA_BIN:$ECLIPSE_HOME:$VIRTUALENV:$CATALINA_HOME:$EC2_BIN:$NODE_PATH:$AUTOJUMP_BIN:$X11_BIN:$USR_LOCALGIT_BIN:$ANT_BIN:$NPM_BIN:$IBM_FIT_DEPLOYER

PATH=$PATH:/opt/local/bin:/opt/local/sbin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH

#[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

export EDITOR=vim
