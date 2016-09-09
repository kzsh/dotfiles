#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

"$DIR/install/install_homebrew.sh"
"$DIR/install/install_brews.sh"
"$DIR/install/install_casks.sh"
"$DIR/install/setup_dotfiles.sh"
"$DIR/install/osx_preferences.sh"
