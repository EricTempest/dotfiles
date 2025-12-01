# OMZ
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended 

cat zsh/.zshrc >> ~/.zshrc


# Stop alternate symbol suggestions on key hold
defaults write -g ApplePressAndHoldEnabled -bool false


# homebrew
export HOMEBREW_BUNDLE_FILE="~/dotfiles/brew/Brewfile"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install brew stuff
./update.sh

eval "$(direnv hook zsh)"
