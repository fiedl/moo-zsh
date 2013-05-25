#
# ~/.zprofile
#
#LANG=en_US.UTF-8
export STEAM_FRAME_FORCE_CLOSE=1
export EDITOR="nano"
export PATH=$PATH:/usr/local/bin
#export WEBKIT_IGNORE_SSL_ERRORS="1" midori
export MOZ_PLUGIN_PATH="/usr/lib/mozilla/plugins"
#export XDG_CACHE_HOME=/dev/shm/$HOME/.cache
if [ ! -f $XDG_CACHE_HOME ];
then
    mkdir -p -m 0700 $XDG_CACHE_HOME
fi

# welcome audio message
ogg123 -q "${HOME}/.config/awesome/sounds/voice-welcome.ogg"
cowsay -f "$(ls /usr/share/cows/ | sort -R | head -1)" "$(fortune -s)"
ogg123 -q "${HOME}/.config/awesome/sounds/voice-please-confirm.ogg"

# ssh-agent
if [ -f "${HOME}/.ssh/id_rsa" ] ; then
	eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
	ogg123 -q "${HOME}/.config/awesome/sounds/voice-piy.ogg"
fi

# # mounted success files
# tc1="/media/truecrypt1/test"
# tc2="/media/truecrypt2/test"
# tc3="/media/truecrypt1/EncryptedDropbox/test"
# thd1="/home/pdq/vital/hiddenfiles"
# thd2="/media/HDD2p/pdq/vital/hiddenfiles2"

# if [ -f "$tc1" ] ; then
# 	echo "[SKIP] It appears your primary data is already mounted, proceeding to secondary data..."
# else
# 	echo "[WAIT] Decrypt primary data and proceed to desktop session"
	
# 	if [ -f "$thd1" ] ; then
# 		truecrypt -k "" --protect-hidden=no $thd1 /media/truecrypt1
# 	else
# 		echo "[ERROR] 1. No Encrypted Source drive found :("
# 	fi
# 	if [ -f "$tc1" ] ; then
# 		echo "mounted /media/truecrypt1"
# 		ogg123 -q "${HOME}/.config/awesome/sounds/voice-accepted.ogg"
# 	else
# 		echo "Incorrect passphrase..."
# 		ogg123 -q "${HOME}/.config/awesome/sounds/voice-access-denied.ogg"
# 	fi
# fi

# if [ -f "$tc2" ] ; then
# 	echo "[SKIP] It appears your secondary data is already mounted, proceeding to USB..."
# else
# 	echo "[WAIT] Decrypt secondary data and proceed to USB"
# 	if [ -f "$thd2" ] ; then
# 		truecrypt -k "" --protect-hidden=no $thd2 /media/truecrypt2
# 	else
# 		echo "[ERROR] 2. No Encrypted Source drive found :("
# 	fi
# 	if [ -f "$tc2" ] ; then
# 		echo "mounted /media/truecrypt2"
# 		ogg123 -q "${HOME}/.config/awesome/sounds/voice-accepted.ogg"
# 	else
# 		echo "Incorrect passphrase...secondary data not mounted"
# 		ogg123 -q "${HOME}/.config/awesome/sounds/voice-access-denied.ogg"
# 	fi
# fi
# ogg123 -q "${HOME}/.config/awesome/sounds/voice-secure.ogg"

# if [ -f "$tc3" ] ; then
# 	echo "[SKIP] It appears your dropbox data is already mounted, proceeding to desktop session..."
# else
# 	echo "[WAIT] Decrypt dropbox data and proceed to desktop session"
	
# 	if [ -f "$tc1" ] ; then
# 		encfs ${HOME}/Dropbox/.encrypted /media/truecrypt1/EncryptedDropbox
# 	else
# 		echo "[ERROR] 3. No Encrypted Source drive found :("
# 	fi
# 	if [ -f "$tc3" ] ; then
# 		echo "mounted /media/truecrypt1/EncryptedDropbox"
# 		ogg123 -q "${HOME}/.config/awesome/sounds/voice-accepted.ogg"
# 	else
# 		echo "Incorrect passphrase...dropbox data not mounted"
# 		ogg123 -q "${HOME}/.config/awesome/sounds/voice-access-denied.ogg"
# 	fi
# fi
cowsay -f "$(ls /usr/share/cows/ | sort -R | head -1)" "$(fortune -s)"
[[ -f ~/.zshrc ]] && . ~/.zshrc
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
