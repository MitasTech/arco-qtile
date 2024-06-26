#!/bin/bash
#set -e
###############################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxb.com
# Website	:	https://www.arcolinuxiso.com
# Website	:	https://www.arcolinuxforum.com
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
###############################################################################


###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################

echo -ne "


                     ██████╗ ████████╗██╗██╗     ███████╗                  
                    ██╔═══██╗╚══██╔══╝██║██║     ██╔════╝                  
                    ██║   ██║   ██║   ██║██║     █████╗                    
                    ██║▄▄ ██║   ██║   ██║██║     ██╔══╝                    
                    ╚██████╔╝   ██║   ██║███████╗███████╗                  
                     ╚══▀▀═╝    ╚═╝   ╚═╝╚══════╝╚══════╝                  
                                                                           
 █████╗ ██████╗  ██████╗██╗  ██╗    ███╗   ███╗██╗████████╗ █████╗ ███████╗
██╔══██╗██╔══██╗██╔════╝██║  ██║    ████╗ ████║██║╚══██╔══╝██╔══██╗██╔════╝
███████║██████╔╝██║     ███████║    ██╔████╔██║██║   ██║   ███████║███████╗
██╔══██║██╔══██╗██║     ██╔══██║    ██║╚██╔╝██║██║   ██║   ██╔══██║╚════██║
██║  ██║██║  ██║╚██████╗██║  ██║    ██║ ╚═╝ ██║██║   ██║   ██║  ██║███████║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝
                                                                           

---------------------------------------------------------------------------
                Automated Installation for my Qtile Setup
                            by Stelios Mitas
---------------------------------------------------------------------------


"
sleep 1

AUR_HELPER=("yay" "paru" "pakku" "paccaur" "trizen" "aura" "pikaur")

func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
sddm
arcolinux-wallpapers-git
thunar
arconet-xfce
arcolinux-qtile-distrotube-git
sxhkd
dmenu
sublime-text-4
kitty
firefox
feh
python-psutil
xcb-util-cursor
arcolinux-qtile-git
arcolinux-dconf-all-desktops-git
arcolinux-config-all-desktops-git
awesome-terminal-fonts
archlinux-logout-git
python-setuptools
timeshift
)

$AUR_HELPER -Sy qtile-extras grub-btrfs timeshift-autosnap

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

###############################################################################

tput setaf 6;echo "################################################################"
echo "Copying all files and folders from /etc/skel to ~"
echo "################################################################"
echo;tput sgr0
cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
cp -arf /etc/skel/. ~

tput setaf 5;echo "################################################################"
echo "Enabling sddm as display manager"
echo "################################################################"
echo;tput sgr0
sudo systemctl enable sddm.service -f

tput setaf 7;echo "################################################################"
echo "You now have a very minimal functional desktop"
echo "################################################################"
echo;tput sgr0


#	     Removing Configuration files from .config

rm -rf ~/.config/neofetchrm -rf ~/.config/kitty
rm -rf ~/.config/qtile

#	     Copying Configuration files into .config

cp -r configs/neofetch/ ~/.config/neofetch
cp -r configs/kitty/ ~/.config/kitty
cp -r configs/qtile/ ~/.config/qtile

#	     Copying Background image to Pictures

cp -r configs/0277.jpg ~/Pictures

echo -ne "
----------------------------------------------------------------------
	     		We are done! Enjoy!
----------------------------------------------------------------------
"


tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
