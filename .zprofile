#
# ~/.zprofile
#
#LANG=en_US.UTF-8
export STEAM_FRAME_FORCE_CLOSE=1
export EDITOR="nano"
export PATH=$PATH:/usr/local/bin
#export WEBKIT_IGNORE_SSL_ERRORS="1" midori
export MOZ_PLUGIN_PATH="/usr/lib/mozilla/plugins"
export QT_PLUGIN_PATH=$HOME/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/
#export XDG_CACHE_HOME=/dev/shm/$HOME/.cache
if [ ! -f $XDG_CACHE_HOME ]; then
    mkdir -p -m 0700 $XDG_CACHE_HOME
fi

# welcome audio message
#ogg123 -q "${HOME}/.config/awesome/sounds/voice-welcome.ogg"
cowsay -f "$(ls /usr/share/cows/ | sort -R | head -1)" "$(fortune -s)"
#ogg123 -q "${HOME}/.config/awesome/sounds/voice-please-confirm.ogg"

# ssh-agent
if [ -f "${HOME}/.ssh/id_rsa" ] ; then
	eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
	#ogg123 -q "${HOME}/.config/awesome/sounds/voice-piy.ogg"
fi

# mounted success files
#tc1="/media/truecrypt3/test"
#thd1="/dev/sdb"

#if [ -f "$tc1" ] ; then
# 	echo "[SKIP] It appears your primary data is already mounted, proceeding to secondary data..."
#else
 # 	echo "[WAIT] Decrypt primary data and proceed to desktop session"

	# truecrypt -k "" --protect-hidden=no $thd1 /media/truecrypt3

 # 	if [ -f "$tc1" ] ; then
 # 		echo "mounted /media/truecrypt3"
 # 		#ogg123 -q "${HOME}/.config/awesome/sounds/voice-accepted.ogg"
 # 	else
 # 		echo "Incorrect passphrase..."
 # 		#ogg123 -q "${HOME}/.config/awesome/sounds/voice-access-denied.ogg"
 # 	fi
 # fi

cowsay -f "$(ls /usr/share/cows/ | sort -R | head -1)" "$(fortune -s)"
[[ -f ~/.zshrc ]] && . ~/.zshrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
