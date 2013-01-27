HISTFILE=~/.histfile_`hostname`
HISTSIZE=5000
SAVEHIST=3000
HISTFILESIZE=${HISTSIZE}                    # bash will remember N commands
HISTCONTROL=ignoreboth                      # ingore duplicates and spaces (ignoreboth, ignoredups, ignorespace)
# don't append the following to history: consecutive duplicate
# commands, ls, bg and fg, and exit
HISTIGNORE='\&:fg:bg:ls:pwd:cd ..:cd ~-:cd -:cd:jobs:set -x:ls -l:ls -l'
HISTIGNORE=${HISTIGNORE}':%1:%2:shutdown*'
export HISTIGNORE
export PATH="/usr/lib/cw:$PATH"

# if exists, add ~/bin to PATH
if [ -d ~/bin ] ; then
   PATH=~/bin:$PATH
fi

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

bindkey -e

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 1. All /etc/hosts hostnames are in autocomplete
if [ -f $HOME/.ssh/known_hosts ] ; then
    hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
    zstyle ':completion:*:hosts' hosts $hosts
fi
# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort

setopt completealiases
setopt autocd

autoload -Uz compinit
compinit

autoload -U promptinit
promptinit

#autoload -U colors && colors
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.

function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}

zle -N zle-line-init
zle -N zle-line-finish

watch=all
LOGCHECK=60
# End of lines added by compinstall
# This will set the default prompt to the walters theme
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

prompt_char(){
    [[ -n $vcs_info_msg_0_ ]] && echo '╘═😸 ' && return
    echo '└─╼ '
}

vi-git-status () {
  # Untracked files.
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    hook_com[unstaged]='%F{r}?%f'
  fi
}

prompt_gtmanfred_precmd(){
    vcs_info
}

prompt_gtmanfred_help(){
  cat <<EOH
gtmanfred's prompt
EOH
}

prompt_gtmanfred_setup() {
    setopt prompt_subst
    autoload -U colors && colors
    autoload -Uz add-zsh-hook vcs_info

    prompt_opts=(cr percent subst)
    add-zsh-hook precmd prompt_gtmanfred_precmd

    zstyle ':vcs_info:*' enable bzr git hg svn
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '%F{g}●%f'
    zstyle ':vcs_info:*' unstagedstr '%F{y}!%f'
    zstyle ':vcs_info:*' formats 'on %F{m}%b%c%u%F{n}'
    zstyle ':vcs_info:*' actionformats "%b%c%u|%F{c}%a%f"
    zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b|%F{c}%r%f'
    zstyle ':vcs_info:git*+set-message:*' hooks git-status

    PROMPT='┌─ %B%F{blue}%n%f%b %F{green}at%f %B%F{blue}%m%f%b %F{green}in%f %B%F{blue}%~%f%b ${vcs_info_msg_0_}%{$reset_color%}$prompt_newline$(prompt_char)%f'

    RPROMPT="%(?,%F{blue}(⌐■_■),%F{yellow}%? %F{red}（╯°□°）╯︵ ┻━┻)%f"
    PS4='+%N:%i:%x:%I>'
}

prompt_gtmanfred_preview(){
    prompt_preview_theme gtmanfred "$@"
}
prompt_gtmanfred_setup "$@"

# Window title
case $TERM in
    termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
		precmd () { print -Pn "\e]0;[%n@%M][%~]%#\a" } 
		preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
	;;
    screen)
    	precmd () { 
			print -Pn "\e]83;title \"$1\"\a" 
			print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
		}
		preexec () { 
			print -Pn "\e]83;title \"$1\"\a" 
			print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
		}
	;; 
esac

# hub tab-completion script for zsh.
# This script complements the completion script that ships with git.

# Autoload _git completion functions
if declare -f _git > /dev/null; then
  _git
fi

if declare -f _git_commands > /dev/null; then
  _hub_commands=(
    'alias:show shell instructions for wrapping git'
    'pull-request:open a pull request on GitHub'
    'fork:fork origin repo on GitHub'
    'create:create new repo on GitHub for the current project'
    'browse:browse the project on GitHub'
    'compare:open GitHub compare view'
  )
  # Extend the '_git_commands' function with hub commands
  eval "$(declare -f _git_commands | sed -e 's/base_commands=(/base_commands=(${_hub_commands} /')"
fi

set -o notify 

screenfetch -D "Arch Linux - pdq"

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo -e "\n${RED}Open connections :$NC "; netstat -pan --inet;
    echo
}
# usage: remind <time> <text>
# e.g.: remind 10m "omg, the pizza"
function remind()
{
    sleep $1 && notify-send "$2" &
}
alias c='clear'
alias f='file'
alias ls='ls --color=auto'
alias ping='ping -c 5'
alias pong='tsocks ping -c 5'
# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# fun stuffs
#alias bender='cowsay -f bender $(fortune -so)'
alias matrix='cmatrix -C magenta'
# useful stuffs
alias ..='cd ..'
alias home='cd ~'
alias conf='cd ~/.config'
alias dev='cd ~/Development'
alias down='cd ~/Downloads'
alias backup='sh ~/github/pdq/backup.sh'
alias nc='ncmpcpp'
alias grep='grep --color=auto'
alias mounthdd='sudo udisks --mount /dev/sdb4'
alias mounthdd3='sudo udisks --mount /dev/sdb3'
#alias sploit='/opt/metasploit-4.2.0/msfconsole'
alias kdeicons='rm ~/.kde4/cache-linux/icon-cache.kcache'
alias deltrash1='sudo rm -rv /media/truecrypt1/.Trash-1000/'
alias deltrash2='sudo rm -rv /media/truecrypt2/.Trash-1000/'
alias deltrash='rm -rv ~/.local/share/Trash/'
alias sdeltrash1='sudo srm -rv /media/truecrypt1/.Trash-1000/'
alias sdeltrash2='sudo srm -rv /media/truecrypt2/.Trash-1000/'
alias sdeltrash='srm -rv ~/.local/share/Trash/'
alias delthumbs='srm -rv ~/.thumbnails/'
alias reload='source ~/.zshrc'
alias xdef='xrdb -merge ~/.Xdefaults' 
alias flushdns="sudo /etc/rc.d/nscd restart"
alias delfonts='fc-cache -vf'
alias cclean='sudo cacheclean -v 1'
alias sd='systemctl'
alias md5='md5sum'
#alias pdq='~/bin/pdqutil'
#alias startx='startx &> ~/.xlog'
#alias irssi='urxvt -e irssi &'
#alias finch='urxvt -e finch &'
alias mirror='sudo reflector -c "Canada United States" -f 6 > mirrorlist'
#alias tor='~/.tor-browser_en-US/start-tor-browser'
# control hardware
#alias cdo='eject /dev/cdrecorder'
#alias cdc='eject -t /dev/cdrecorder'
#alias dvdo='eject /dev/dvd'
#alias dvdc='eject -t /dev/dvd'
# modified commands
alias psg='ps aux | grep'  #requires an argument
# chmod commands
#alias mx='chmod a+x' 
#alias 000='chmod 000' 😸
#alias 644='chmod 644'
#alias 755='chmod 755'
# pacman
alias p="sudo pacman-color -S"         # install one or more packages
alias pp="pacman-color -Ss"            # search for a package using one or more keywords
alias syu="sudo pacman-color -Syu"     # upgrade all packages to their newest version
alias pacremove="sudo pacman-color -R" # uninstall one or more packages
alias rs="sudo pacman-color -Rs"       # uninstall one or more packages and its dependencies 
# packer
# alias a="packer-color"
# alias sa="packer-color -S"
# alias syua="packer-color -Syu --auronly"
# powerpill
alias pillu="sudo powerpill -Syu"
alias pill="sudo powerpill -S"
alias a="pacaur -S"               # search packages
alias aa="pacaur -s"              # install package
alias syua="pacaur -Syua"         # update aur packages
alias syud="pacaur -Syua --devel" # update devel packages
# cower
alias cow="cower -u -v"
# git hub
alias git=hub
alias commit="git commit -m"
alias push="git push origin master"
# systemd services
alias trstart='sudo systemctl start transmission'
alias trstop='sudo systemctl stop transmission'
alias scripts='sh ~/.config/awesome/global_script.sh'
# suffix aliases
alias -s php=subl
alias -s html=luakit
alias -s png=gpicview
alias -s jpg=gpicview
alias -s gif=gpicview
alias -s GIF=gpicview
alias -s JPG=gpicview
alias -s PNG=gpicview
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR
hash -d github=$HOME/github
hash -d movies=/media/truecrypt2/movies
hash -d tvshows=/media/truecrypt1/tv
hash -d units=/usr/lib/systemd/system/
# global aliases
alias -g ...='../..'
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g G='| egrep'
alias -g H='| head'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g L="| less"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g S='| sort'
alias -g T='tail -f'
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
