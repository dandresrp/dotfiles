### ADDING TO THE PATH
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

### EXPORT ###
set fish_greeting 
set TERM "xterm-256color"
export EDITOR='nvim'
export EDITOR2='code'

### ALIASES ###

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

# pacman
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias cleanup='sudo pacman -R (pacman -Qtdq)'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# mirrors
alias update-mirrors="sudo reflector --country 'United States' --download-timeout 60 --sort rate --age 12 --protocol https --save /etc/pacman.d/mirrorlist"

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

# edit config files with gui
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
alias sqtile="$EDITOR2 ~/.config/qtile/ && exit"
alias salacritty="$EDITOR2 ~/.config/alacritty/alacritty.yml && exit"
alias sb="$EDITOR2 ~/.bashrc && exit"
alias sf="$EDITOR2 ~/.config/fish/config.fish && exit"

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
