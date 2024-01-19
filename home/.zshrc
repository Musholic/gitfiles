# Desactivate grml prompt if necessary
type prompt > /dev/null 2>&1 && prompt off

# Use zsh history on disk if available
if [ -f "$DISK/user/appconfigs/.zsh_history" ]; then
    HISTFILE="$DISK/user/appconfigs/.zsh_history"
fi

# Disable oh-my-zsh automatic update
DISABLE_AUTO_UPDATE=true

source "${HOME}/git/sys/zgen/zgen.zsh"
#
# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    zgen oh-my-zsh plugins/archlinux
    zgen oh-my-zsh plugins/colored-man-pages
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-extras
    zgen oh-my-zsh plugins/git-flow-avh
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/zsh-navigation-tools

    zgen load djui/alias-tips
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-completions src

    zgen load romkatv/powerlevel10k powerlevel10k

    # save all to init script
    zgen save
fi

#set some env for oh-my-zsh
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_UPDATE="true"
 
alias yin='yay --needed -S'
alias yinnoconfirm='yay --needed --noconfirm -S'
alias yins='yay -U'
alias yinsd='yay -S --asdeps'
alias yloc='yay -Qi'
alias ylocs='yay -Qs'
alias ylsorphans='yay -Qdt'
alias ymir='yay -Syy'
alias yre='yay -R'
alias yrem='yay -Rns'
alias yrep='yay -Si'
alias yreps='yay -Ss'
alias yrmorphans='yay -Rs $(pacaur -Qtdq)'
alias yupd='yay -Sy'
alias yupg='yay -Syu'

alias wh="which"
alias -g G='| nocorrect ack'
alias -g GG='| nocorrect ack --passthru'
alias lim="trickle -d500"
alias du1="du -h -d1"
alias tree0="tree -ah --du"
alias tree0p="tree -ahpug --du"
alias tree1="tree -ah --du -L 2"

alias myip="curl ipecho.net/plain ; echo"

alias format="astyle -A2"

alias gA="git add -A"
alias glp="git log -p --color-words"
alias gd="git diff --color-words --find-renames"
alias gdc="git diff --cached --color-words --find-renames"
alias gff="git flow feature"
alias gfb="git flow bugfix"
alias gfr="git flow release"
alias gfh="git flow hotfix"

alias z="zathura"
alias v="vim"
alias f="feh -."

alias cdnolink='cd `readlink -f .`'
alias npm-exec='PATH=$(npm bin):$PATH'
alias o='xdg-open'
alias p='pgrep -a'

hash -d gf=$DISK/sys/gitfiles
hash -d disk=$DISK
hash -d appconfigs=$DISK/user/appconfigs
hash -d softs=$DISK/user/softwares
hash -d smd=$DISK/user/git/storemydocs
hash -d plaxel=$DISK/user/git/plaxelss
hash -d git=$DISK/user/git

# Functions

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    bg
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Other
eval $(dircolors -b ~/.dir_colors) 
setopt histignorealldups
unsetopt hist_save_by_copy

#Fix vim typing
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line

alias s='sudo -E '
# Support man of alias
alias man='man '
alias ssh='ssh-add -l > /dev/null || ssh-add; TERM=xterm-256color ssh'
alias autossh='ssh-add -l > /dev/null || ssh-add; TERM=xterm-256color autossh'

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                           /usr/sbin /usr/bin /sbin /bin

function ranger-cd {
    tempfile="$(mktemp)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

function ranger-cd2 {
    ranger < $TTY
    ls -lah
}

# This binds Ctrl-O to ranger-cd:
zle -N ranger-cd2
bindkey '^o' ranger-cd2

export AUTOSSH_PORT=0

alias docker='systemctl is-active docker > /dev/null || ( echo "Starting docker" && sudo systemctl start docker ); docker'

export CHROME_BIN=google-chrome-stable



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Base16 Shell
BASE16_SHELL="$HOME/git/sys/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"


# Load Angular CLI autocompletion.
if which ng &> /dev/null; then
    source <(ng completion script)
fi
