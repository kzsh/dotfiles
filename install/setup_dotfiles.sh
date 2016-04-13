CURR_DIR=$(pwd)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GITHUB_DIR=~/src/github
SRC_DIR=~/src/local
CONFIG_DIR=~/.config
NVIM_DIR=$CONFIG_DIR/nvim

git clone git@github.com:kzsh/dotfiles.git $GITHUB_DIR/dotfiles

git clone git@github.com:kzsh/.vim.git $GITHUB_DIR/vim
cd $GITHUB_DIR/vim
git submodule update --recursive
cd $CURR_DIR

mkdir -p $NVIM_DIR
ln -s $GITHUB_DIR/vim/.vimrc ~/.vimrc
ln -s $GITHUB_DIR/vim $NVIM_DIR



ln -s $GITHUB_DIR/dotfiles/.tigrc ~/.tigrc
ln -s $GITHUB_DIR/dotfiles/.gitk ~/.gitk
ln -s $GITHUB_DIR/dotfiles/.gitconfig ~/.gitconfig

