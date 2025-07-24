# OMZ
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended 

cat zsh/.zshrc >> ~/.zshrc


# homebrew
export HOMEBREW_BUNDLE_FILE="~/dotfiles/brew/Brewfile"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

./update.sh
