#!/usr/bin/env bash


if [ "$(id -u)" = 0 ]; then
    echo "Not to be run as root because it makes changes to \$HOME directory of \$USER"
    exit 1
fi

error() { \
    clear; printf "ERROR:\\n%s\\n" "$1" >&2; exit 1;
}

export NEWT_COLORS="
root=,blue
window=,black
shadow=,blue
border=blue,black
title=blue,black
textbox=blue,black
radiolist=black,black
label=black,blue
checkbox=black,blue
compactbutton=black,blue
button=black,red"

distrowarning() { \
    whiptail --title "Installing watermelonOS!" --msgbox "WARNING! Only works with artixlinux openrc." 16 60 || error "User choose to exit."
}

grep -qs "ID=artix" /etc/os-release || distrowarning

lastchance() { \

    whiptail --title "Are You Sure You Want To Do This?" --yesno "Shall we begin?" 8 60 || { clear; exit 1; }
}

lastchance || error "User choose to exit."


addrepo() { \
    echo "#########################################################"
    echo "## Adding the Artix Universe and Omniverse and Arch repositories to /etc/pacman.conf ##"
    echo "#########################################################"
    grep -qxF "[universe]" /etc/pacman.conf ||
        ( echo " "; echo "[universe]"; \
        echo "Server = https://mirror.pascalpuffke.de/artix-universe/$arch") | sudo tee -a /etc/pacman.conf
    grep -qxF "[omniverse]" /etc/pacman.conf ||
        ( echo " "; echo "[omniverse]"; \
        echo "Server = https://eu-mirror.artixlinux.org/omniverse/$arch") | sudo tee -a /etc/pacman.conf
    sudo pacman -Sy
    sudo pacman -S systemd
    grep -qxF "[extra]" /etc/pacman.conf ||
        ( echo " "; echo "[extra]"; \
        echo "Include = /etc/pacman.d/mirrorlist-arch") | sudo tee -a /etc/pacman.conf
    grep -qxF "[multilib]" /etc/pacman.conf ||
        ( echo " "; echo "[multilib]"; \
        echo "Include = /etc/pacman.d/mirrorlist-arch") | sudo tee -a /etc/pacman.conf
    sudo pacman -Sy
}

addrepo || error "Error adding repos to /etc/pacman.conf."

addmypackages() {\
        sudo pacman -S librewolf steam wine keepassxc neovim







}
