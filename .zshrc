# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=3000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pdq/.zshrc'
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
# New completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
# then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# http://www.sourceguru.net/ssh-host-completion-zsh-stylee/
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
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

autoload -Uz compinit
compinit

autoload -U promptinit
promptinit

#prompt bart

autoload -U colors && colors
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
# End of lines added by compinstall
# This will set the default prompt to the walters theme
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

PROMPT=$'%(?..%{\e[41;38m%}%B-%?-%b%{\e[0m%} )%(1j.%{\e[01;33m%}[%j] .)%{\e[01;36m%}%n@%m%{\e[0m%} %{\e[01;32m%}%2~%{\e[0m%} %B%#%b '
#RPROMPT=$'%{\e[01;31m%}[%!]%{\e[0m%} %B%@%b %U%D{%a}%u'
# https://github.com/yonchu/zsh-vcs-prompt
ZSH_VCS_PROMPT_USING_PYTHON='false'
source ~/.zsh/git-prompt/zshrc.sh
RPROMPT=$'$(git_super_status) %{\e[01;31m%}[%!]%{\e[0m%}%B%@%b'

#------------------------------
# Window title
#------------------------------
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
# black, red, green, yellow, blue, magenta, cyan, white
[ ! "$UID" = "0" ] && archey3 -c cyan
[  "$UID" = "0" ] && archey3 -c red
#command cowsay $(fortune)
#PS1="\[\e[01;31m\]┌─[\[\e[01;35m\u\e[01;31m\]]──[\[\e[00;37m\]${HOSTNAME%%.*}\[\e[01;32m\]]:\w$\[\e[01;31m\]\n\[\e[01;31m\]└──\[\e[01;36m\]>>\[\e[0m\]"
#PS1="\n${DGRAY}╭─[${LBLUE}\w${DGRAY}]\n${DGRAY}╰─[${WHITE}\T${DGRAY}]${DGRAY}>${BLUE}>${LBLUE}> ${RESET_COLOR}"
#complete -cf sudo
#complete -cf man
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
alias c='clear'
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
alias backup=' sh ~/Development/pdq/backup.sh'
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
#alias 000='chmod 000'
#alias 644='chmod 644'
#alias 755='chmod 755'
# pacman
alias s="sudo pacman-color -S"      # default action     - install one or more packages
alias sss="pacman-color -Ss"           # '[s]earch'         - search for a package using one or more keywords
alias syu="sudo pacman-color -Syu"     # '[u]pdate'         - upgrade all packages to their newest version
alias pacremove="sudo pacman-color -R"       # '[r]emove'         - uninstall one or more packages
alias rs="sudo pacman-color -Rs"     # '[r]emove'         - uninstall one or more packages and its dependencies 
#packer
alias a="packer-color"
alias sa="packer-color -S"
alias syua="packer-color -Syu --auronly"
# suffix aliases
alias -s php=subl
alias -s html=luakit
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
# remote server
source ~/.bash_ssh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
