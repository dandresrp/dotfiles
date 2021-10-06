### ADDING TO THE PATH
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

### EXPORT ###
set fish_greeting 
set TERM "xterm-256color"
export EDITOR='vim'
export EDITOR2='subl'

if status is-interactive
    # Commands to run in interactive sessions can go here
end

### ALIASES ###

# bat
# alias cat='bat'

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# Add clear to ls
alias cls='clear && ls'
alias cla='clear && la'  
alias cll='clear && ll'
alias clt='clear && lt'
alias cl.='clear && l.'

# pacman
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias cleanup='sudo pacman -R (pacman -Qtdq)'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin main'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 --config-location ~/.config/youtube-dl/config-music "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio --config-location ~/.config/youtube-dl/config-video "

# mirrors
alias mirrors="sudo reflector --country 'United States' --sort rate --age 12 --protocol https --save /etc/pacman.d/mirrorlist"

# grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# edit config files with VIM
alias vlightdm="sudo $EDITOR /etc/lightdm/lightdm.conf"
alias vpacman="sudo $EDITOR /etc/pacman.conf"
alias vgrub="sudo $EDITOR /etc/default/grub"
alias vmkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf"
alias vmirrorlist="sudo $EDITOR /etc/pacman.d/mirrorlist"
alias vsddm="sudo $EDITOR /etc/sddm.conf"
alias vfstab="sudo $EDITOR /etc/fstab"
alias vrofi="sudo $EDITOR ~/.config/rofi/config.rasi"
alias vxmonad="sudo $EDITOR ~/.xmonad/xmonad.hs"
alias vxmobar="sudo $EDITOR ~/.config/xmobar/xmobarrc"
alias vawesome="sudo $EDITOR ~/.config/awesome/rc.lua"
alias vqtile="sudo $EDITOR ~/.config/qtile/config.py"
alias valacritty="sudo $EDITOR ~/.config/alacritty/alacritty.yml"
alias vb="$EDITOR ~/.bashrc"
alias vf="$EDITOR ~/.config/fish/config.fish"

# edit config files with SUBLIME
alias slightdm="$EDITOR2 /etc/lightdm/lightdm.conf && exit"
alias spacman="$EDITOR2 /etc/pacman.conf && exit"
alias sgrub="$EDITOR2 /etc/default/grub && exit"
alias smkinitcpio="$EDITOR2 /etc/mkinitcpio.conf && exit"
alias smirrorlist="$EDITOR2 /etc/pacman.d/mirrorlist && exit"
alias ssddm="$EDITOR2 /etc/sddm.conf && exit"
alias sfstab="$EDITOR2 /etc/fstab && exit"
alias srofi="$EDITOR2 ~/.config/rofi/config.rasi && exit"
alias sxmonad="$EDITOR2 ~/.xmonad/xmonad.hs && exit"
alias sxmobar="$EDITOR2 ~/.config/xmobar/xmobarrc && exit"
alias sawesome="$EDITOR2 ~/.config/awesome/rc.lua && exit"
alias sqtile="$EDITOR2 ~/.config/qtile/config.py && exit"
alias salacritty="$EDITOR2 ~/.config/alacritty/alacritty.yml && exit"
alias sb="$EDITOR2 ~/.bashrc && exit"
alias sf="$EDITOR2 ~/.config/fish/config.fish && exit"

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

#arcolinux logout unlock
alias rmlogoutlock="sudo rm /tmp/arcologout.lock"

#arcolinux applications
alias att="arcolinux-tweak-tool"
alias adt="arcolinux-desktop-trasher"
alias abl="arcolinux-betterlockscreen"
alias agm="arcolinux-get-mirrors"
alias amr="arcolinux-mirrorlist-rank-info"
alias aom="arcolinux-osbeck-as-mirror"
alias ars="arcolinux-reflector-simple"
alias atm="arcolinux-tellme"
alias avs="arcolinux-vbox-share"
alias awa="arcolinux-welcome-app"

#continue download
alias wget="wget -c -P ~/Downloads/"

#grub update
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

# updatedb for mlocate
alias udb='sudo updatedb'

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

### NEOFETCH ###
#neofetch
