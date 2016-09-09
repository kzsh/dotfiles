brew install bash
brew install ag
brew install wget
brew install python3
brew install tmux
brew install tig
brew install autojump
brew install direnv
brew install shellcheck
brew install pass
brew install tree

# tmux
brew install reattach-to-user-namespace


echo '[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh' >> ~/.bash_aliases

brew tap neovim/neovim
brew install --HEAD neovim
