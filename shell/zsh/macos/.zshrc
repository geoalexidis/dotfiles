# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH enhancing
export PATH=/opt/homebrew/bin:$PATH
export PATH=/home/$USER/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# see https://github.com/tarjoilija/zgen#installation
# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then

  # specify plugins here
  zgen oh-my-zsh

  zgen oh-my-zsh plugins/archlinux
  zgen oh-my-zsh plugins/autojump
  zgen oh-my-zsh plugins/alias-finder
  zgen oh-my-zsh plugins/command-not-found
  # zgen oh-my-zsh plugins/composer
  zgen oh-my-zsh plugins/cp
  zgen oh-my-zsh plugins/docker-compose
  zgen oh-my-zsh plugins/docker-machine
  zgen oh-my-zsh plugins/docker
  zgen oh-my-zsh plugins/dotenv
  zgen oh-my-zsh plugins/emoji
  zgen oh-my-zsh plugins/fzf
  # zgen oh-my-zsh plugins/gem
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/git-auto-fetch
  zgen oh-my-zsh plugins/git-lfs
  zgen oh-my-zsh plugins/git-prompt
  zgen oh-my-zsh plugins/gitfast
  zgen oh-my-zsh plugins/github
  zgen oh-my-zsh plugins/gitignore
  zgen oh-my-zsh plugins/golang
  zgen oh-my-zsh plugins/gpg-agent
  zgen oh-my-zsh plugins/jsontools
  zgen oh-my-zsh plugins/jump
  zgen oh-my-zsh plugins/lxd
  zgen oh-my-zsh plugins/nmap
  zgen oh-my-zsh plugins/node
  zgen oh-my-zsh plugins/npm
  # zgen oh-my-zsh plugins/npx
  # zgen oh-my-zsh plugins/nvm
  zgen oh-my-zsh plugins/pip
  zgen oh-my-zsh plugins/pipenv
  zgen oh-my-zsh plugins/pyenv
  zgen oh-my-zsh plugins/python
  # zgen oh-my-zsh plugins/rust
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/tmux
  # zgen oh-my-zsh plugins/torrent
  zgen oh-my-zsh plugins/vi-mode
  # zgen oh-my-zsh plugins/vim-interaction
  zgen oh-my-zsh plugins/yarn
  zgen oh-my-zsh plugins/zsh-interactive-cd
  zgen oh-my-zsh plugins/zsh-navigation-tools
  zgen oh-my-zsh plugins/zsh_reload

  # others
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-history-substring-search

  # load theme powerlevel10k
  zgen load romkatv/powerlevel10k powerlevel10k
  
  # generate the init script from plugins above
  zgen save
fi

# for tmux
export TERM=xterm-256color
export EDITOR=nvim

# at the end enter our home
cd ~

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias ils='logo-ls'
alias ila='logo-ls -al'
alias ill='logo-ls -A'
# equivalents with Git Status on by Default
alias ilsg='logo-ls -D'
alias ilag='logo-ls -alD'
alias illg='logo-ls -AD'

# for st from siduck76
# https://github.com/siduck76/st#how-to-apply-xresources-and-live-reload-
# command : use Xresourcesfile && load
alias load="kill -USR1 $(pidof st)"
alias use="xrdb merge"
alias lv=lvim
alias gs="g status"
alias gcm="g commit -m"
alias gpl="g pull"
alias gco="g checkout"
alias gcob="g checkout -b"
alias gr="g rebase"

eval $(thefuck --alias)

#autojump
[[ -s /Users/gk/.autojump/etc/profile.d/autojump.sh ]] && source /Users/gk/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# pnpm
export PNPM_HOME="/home/lgg/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
# golang
export PATH="/usr/local/go/bin/:$PATH"

