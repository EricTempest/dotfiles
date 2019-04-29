sudo apt install git
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
mv nvim.appimage nvim
chmod +x nvim
sudo chown root:root nvim
sudo mv nvim /usr/bin
cd ~
mkdir -p .config/nvim

git clone git@github.com:Wobrav/dotfiles.git
cd ~/.config/nvim/bundle
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/scrooloose/syntastic
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/shougo/deoplete.nvim
git clone https://github.com/zchee/deoplete-go
git clone https://github.com/ddollar/nerdcommenter
git clone https://github.com/fatih/vim-go
