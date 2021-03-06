#
# ~/.bashrc
#

# If not running interactively, don't do anything

#if [[ -z $DISPLAY ]] && [[ $(tty) = "/dev/tty1" ]]; then
#        exec startx
#fi

[[ $- != *i* ]] && return

set -o vi

### alias & binds

umask 0077 #toda vez que o terminal cria um arquivo o arquivo so vai ter permissao de leitura escrita so pro usuario

export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth

bind "\C-l":clear-screen
alias py3s="ip addr | grep inet | tail -2 | head -1 && python3 -m http.server"
alias cdp=' cd ~/MEGA/MEGAsync/programação/'
alias killm='mpvc -k'
alias ls='ls --color=auto'
alias cdd='cd ~/Downloads'
alias f='fff'
alias cdm='cd ~/MEGA/MEGAsync/'
alias cdg='cd ~/MEGA/MEGAsync/docs/gnucash/'
alias cdd='cd ~/MEGA/MEGAsync/docs'
alias cdn='cd ~/MEGA/MEGAsync/docs/updates/'
alias remove='sudo xbps-remove -R'
alias search='xbps-query -Rs'
alias install='sudo xbps-install -S'
alias sinstall='sudo xbps-install --repository=hostdir/binpkgs'
alias rns='sudo xbps-remove -Oo'
alias update='sudo xbps-install -Suvy'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias shutdown='sudo shutdown -h now'
alias mount='sudo mount'
alias umount='sudo umount'
alias zzz='sudo zzz'
alias instsrc='sudo xbps-install --repository=hostdir/binpkgs'
alias ".."='cd ..'
alias "xcp"="pwd | xclip -selection clipboard"
alias ytb='mpv --ytdl-format=22 $1'
alias ytm='mpv --ytdl-format=18 $1'
#alias xcp='xclip -selection clipboard'
#alias nt='notify-send'

extract() {
if [[ -f $1 ]]; then
	case "$1" in
		*.tar.bz2) tar xvjf "$1";;
		*.tar.gz) tar xvzf "$1";;
		*.tar.xz) tar xvf "$1";;
		*.tar) tar xvf "$1";;
		*.tgz) tar xvf "$1";;
		*.xz) tar xvf "$1";;
		*.gz) gunzip "$1";;
		*.zip) unzip "$1";;
		*.rar) unrar x "$1";;
		*.bz2) bzip2 -d "$1" ;;
		*.lzma) unlzma "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*.deb) ar x ./"$1" ;;
		*) echo "'$1' cannot be extracted via extract."
	esac
else
	echo "'$1' is not a valid file"
fi
}

ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

hex_to_rgb() {
    # Usage: hex_to_rgb "#FFFFFF"
    #        hex_to_rgb "000000"
    : "${1/\#}"
    ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
    printf '%s\n' "$r $g $b"
}

wget-extension() {
  if [ $# -lt 2 ]; then
    echo -e "Download all files with specific extension on a webpage"
    echo -e "\nUsage: wget-extension <file_extension> <url>"
    echo -e "\nExample:\nwget-extension mp4 http://example.com/files/"
    echo -e "wget-extension mp3,ogg,wma http://samples.com/files/"
    return 1
  fi

  # savepath=~/Downloads
  # outputdir_name=$(echo "$2" | rev | cut -d\/ -f2 | rev)
  # mkdir -pv "$savepath/$outputdir_name"
  # cd "$savepath/$outputdir_name" && wget -r -l1 -H -t1 -nd -N -np -A "$1" -erobots=off "$2"

  outputdir_name=$(echo "$2" | rev | cut -d\/ -f2 | rev)
  mkdir -pv "$outputdir_name"
  cd "$outputdir_name" && wget -r -l1 -H -t1 -nd -N -np -A "$1" -erobots=off "$2"
}


### terminal indicator

#PS1='[\u@\h \W]\$ '
PS1='\[\033[01;37m\]\W\[\033[01;32m\] - \[\033[00m\]'

PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/butchr/.myscripts

export PANEL_FIFO="/tmp/panel-fifo"
#export PATH="$PATH:$HOME/npm/bin"
#export TERM="st-256color"
export TERM="screen"
#export TERM="xterm-256color"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
