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

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
__zoxide_oldpwd="$(__zoxide_pwd)"

function __zoxide_hook() {
    \builtin local -r retval="$?"
    \builtin local pwd_tmp
    pwd_tmp="$(__zoxide_pwd)"
    if [[ ${__zoxide_oldpwd} != "${pwd_tmp}" ]]; then
        __zoxide_oldpwd="${pwd_tmp}"
        \command zoxide add -- "${__zoxide_oldpwd}"
    fi
    return "${retval}"
}

# Initialize hook.
if [[ ${PROMPT_COMMAND:=} != *'__zoxide_hook'* ]]; then
    PROMPT_COMMAND="__zoxide_hook;${PROMPT_COMMAND#;}"
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

__zoxide_z_prefix='z#'

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ $# -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ $# -eq 1 && $1 == '-' ]]; then
        __zoxide_cd "${OLDPWD}"
    elif [[ $# -eq 1 && -d $1 ]]; then
        __zoxide_cd "$1"
    elif [[ ${@: -1} == "${__zoxide_z_prefix}"?* ]]; then
        # shellcheck disable=SC2124
        \builtin local result="${@: -1}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

\builtin unalias z &>/dev/null || \builtin true
function z() {
    __zoxide_z "$@"
}

\builtin unalias zi &>/dev/null || \builtin true
function zi() {
    __zoxide_zi "$@"
}

# Load completions.
# - Bash 4.4+ is required to use `@Q`.
# - Completions require line editing. Since Bash supports only two modes of
#   line editing (`vim` and `emacs`), we check if either them is enabled.
# - Completions don't work on `dumb` terminals.
if [[ ${BASH_VERSINFO[0]:-0} -eq 4 && ${BASH_VERSINFO[1]:-0} -ge 4 || ${BASH_VERSINFO[0]:-0} -ge 5 ]] &&
    [[ :"${SHELLOPTS}": =~ :(vi|emacs): && ${TERM} != 'dumb' ]]; then
    # Use `printf '\e[5n'` to redraw line after fzf closes.
    \builtin bind '"\e[0n": redraw-current-line' &>/dev/null

    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        [[ ${#COMP_WORDS[@]} -eq $((COMP_CWORD + 1)) ]] || return

        # If there is only one argument, use `cd` completions.
        if [[ ${#COMP_WORDS[@]} -eq 2 ]]; then
            \builtin mapfile -t COMPREPLY < <(
                \builtin compgen -A directory -- "${COMP_WORDS[-1]}" || \builtin true
            )
        # If there is a space after the last word, use interactive selection.
        elif [[ -z ${COMP_WORDS[-1]} ]] && [[ ${COMP_WORDS[-2]} != "${__zoxide_z_prefix}"?* ]]; then
            \builtin local result
            # shellcheck disable=SC2312
            result="$(\command zoxide query --exclude "$(__zoxide_pwd)" --interactive -- "${COMP_WORDS[@]:1:${#COMP_WORDS[@]}-2}")" &&
                COMPREPLY=("${__zoxide_z_prefix}${result}/")
            \builtin printf '\e[5n'
        fi
    }

    \builtin complete -F __zoxide_z_complete -o filenames -- z
    \builtin complete -r zi &>/dev/null || \builtin true
fi
