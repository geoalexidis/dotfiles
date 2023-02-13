#!/bin/bash

# intel compatibiliy
# https://superuser.com/a/1694432
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/gk/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/gk/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# prepare dirs
mkdir ~/repos
mkdir ~/repos/gist -p
mkdir ~/.config/alacritty -p
mkdir ~/.local/share/fonts -p
mkdir ~/.fonts


# packgen
brew install n \ 
gh \
tmux \
docker \
docker-compose \
neovim \
spotify-now-playing \
sd \
duf \
autojump \
bat \
fzf \
tig \
rust \
tldr \
git-delta \
yt-dlp \
wget \
glow \
thefuck \
pidof \
tig

brew install --cask discord \
tradingview \
mullvadvpn \
spotify \
postman \
google-chrome \
brave-browser \
whatsapp \
signal \
spotify-now-playing \
alacritty \
rectangle \
obsidian

# dotfiles and symlinks
cd

git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
git clone https://github.com/geoalexidis/dotfiles.git
git clone https://github.com/gpakosz/.tmux.git
ln -sf ~/dotfiles/shell/tmux/.tmux.conf.local
ln -sf ~/dotfiles/shell/tmux/.tmux.conf
ln -sf ~/dotfiles/shell/.p10k.zsh
ln -sf ~/dotfiles/shell/zsh/macos/.zshrc
cd ~/.config/alacritty && ln -sf ~/dotfiles/terminal/alacritty/alacritty.yml
cd ~/.config/lvim/
ln -sf ~/dotfiles/lunarvim/config.lua
cd ~/.local/share/lunarvim/lvim/lua/lvim/core/
ln -sf ~/dotfiles/lunarvim/which-key.lua
ln -sf ~/dotfiles/.gitignore

# lunarvim
cd ~/.config/lvim/
ln -sf ~/dotfiles/lunarvim/config.lua
cd ~/.local/share/lunarvim/lvim/lua/lvim/core/
ln -sf ~/dotfiles/lunarvim/which-key.lua
