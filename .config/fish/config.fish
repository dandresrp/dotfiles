### ADDING TO THE PATH
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

### EXPORT ###
set fish_greeting
set TERM "xterm-256color"
export EDITOR='subl'

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

# pacman
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias fullremove='sudo pacman -Rcns'
alias update='sudo pacman -Syy'
alias upgrade='sudo pacman -Syu'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# mirrors
alias mirrors-mine="sudo reflector --country 'United States' --sort rate --age 12 --protocol https --save /etc/pacman.d/mirrorlist"
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
#our experimental - best option for the moment
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"

# grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# edit config files
alias elightdm="sudo $EDITOR /etc/lightdm/lightdm.conf && exit"
alias epacman="sudo $EDITOR /etc/pacman.conf && exit"
alias egrub="sudo $EDITOR /etc/default/grub && exit"
alias emkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf && exit"
alias emirrorlist="sudo $EDITOR /etc/pacman.d/mirrorlist && exit"
alias esddm="sudo $EDITOR /etc/sddm.conf && exit"
alias efstab="sudo $EDITOR /etc/fstab && exit"
alias erofi="sudo $EDITOR ~/.config/rofi/config.rasi && exit"
alias exmonad="sudo $EDITOR ~/.xmonad/xmonad.hs && exit"
alias exmobar="sudo $EDITOR ~/.config/xmobar/xmobarrc && exit"
alias eawesome="sudo $EDITOR ~/.config/awesome/rc.lua && exit"
alias eb="$EDITOR ~/.bashrc && exit"
alias ef="$EDITOR ~/.config/fish/config.fish && exit"

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

### SETTING THE STARSHIP PROMPT ###
starship init fish | source

### NEOFETCH ###
neofetch