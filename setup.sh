# zshrc is stored in git. Must link and reload to configure brew
ln zsh/.zshrc ~/.zshrc
source ~/.zshrc

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle install brew/BrewFile
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



