alias l='ls -al'
alias x='exit'
alias h='cd ~'
alias u='cd ..'
alias d='cd Desktop'
alias gst='git status'
alias vnc='vncserver :0 -geometry 1024x768 -depth 16 -pixelformat rgb565:'
alias mem="cat /proc/meminfo | grep MemFree | grep -o -e '[0-9]*'"
alias disk="df -h | grep rootfs | awk '{print \$4}'"
alias enable_sudo_vim="sudo ln -s ~/.vimrc /root/.vimrc"

# Video commands

myvplay()
{
    omxplayer -o hdmi $1
}
alias vplay=myvplay
alias mplay=myvplay

# Volume change commands

# Check volume level
alias volume="amixer get PCM | grep -o -e '[0-9]*%'"

# Increase volume by 5%
myvolup()
{
    vol=$[$(volume | sed 's/%//')+5]%
    sudo amixer set PCM -- $vol
}
alias volup=myvolup

# Decrease volume by 5%
myvoldown()
{
    vol=$[$(volume | sed 's/%//')-5]%
    sudo amixer set PCM -- $vol
}
alias voldown=myvoldown

# This makes the Linux festival system work like the Apple text-to-speech command
mysay()
{
    echo $1 | festival --tts
}
alias say=mysay

