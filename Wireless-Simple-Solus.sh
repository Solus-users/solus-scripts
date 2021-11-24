#!/bin/bash
NAME=wireless-simple-solus
VER=Live

echo -e "\e[32mCopyright (c) 2019-2020, Alexander Vereeken All rights reserved."
echo -e "\e[32mCopyright (c) 2021, Georgii Bogdanov."
echo -e "\e[93mWelcome to $NAME $VER have fun!"

Selection=$(zenity --list --radiolist --height=100 --width 300 --title="$NAME $VER" --text "Welome to $NAME --hide-header --column "$NAME" --column "Item" FALSE "Install dependencies" FALSE "Install driver")

if [[ $Selection == *"Install dependencies"* ]]; then

Distro=$(zenity --list --radiolist --height=300 --width 300 --title="$NAME $VER" --text "Now select a distro" --hide-header --column "$NAME" --column "Item" FALSE "Solus")

PASSWORD=$(zenity --password --title "The Script will now install the requiered dependencies, enter your password to proceed")


if [[ $Distro == *"Solus"* ]]; then
echo $PASSWORD | sudo -S eopkg it gcc binutils git make
SKH=$(zenity --list --radiolist --height=300 --width 100 --title="$NAME $VER" --text "What kernel headers do you want to install?" --hide-header --column "$NAME" --column "Item" FALSE "linux-current-headers" FALSE "linux-lts-headers")
echo $PASSWORD | sudo -S eopkg it $SKH
fi

if [[ $Selection == *"Install driver"* ]]; then
cd /home/$USER
mkdir /home/$USER/$NAME
cd /home/$USER/$NAME
DRV=$(zenity --list --radiolist --height=300 --width 200 --title="$NAME $VER" --text "What driver?" --hide-header --column "$NAME" --column "Item" FALSE "RTL8812au" FALSE "RTL8188/eu/s/etv" FALSE "RTL8821ce" FALSE "RTL8723de" FALSE "RTL8188fu" FALSE "RTL88x2bu")

PASSWORD=$(zenity --password --title "The Script will now install the driver $DRV, enter your password to proceed")

if [[ $DRV == *"RTL8812au"* ]]; then
git clone https://github.com/morrownr/8812au-20210629
cd 8812au-20210629
echo -e "\e[40;38;5;82m Building driver \e[30;48;5;82m\e[0m"
make
echo -e "\e[40;38;5;82m Installing driver \e[30;48;5;82m\e[0m"
echo $PASSWORD | sudo -S "make install"
echo $PASSWORD | sudo -S "modprobe 8812au"
echo -e "\e[40;38;5;82m Done :) \e[30;48;5;82m You can now use your wifi adapter! \e[0m"
cd /home/$USER/Tomomi
rm -d -r rtl8812au-5.9.3.2
fi

if [[ $DRV == *"RTL8188/eu/s/etv"* ]]; then
GB=$(zenity --list --radiolist --height=300 --width 200 --title="$NAME $VER" --text "The driver $DRV has several branches which do you want to use?" --hide-header --column "$NAME" --column "Item" FALSE "v3.5.9" FALSE "v5.2.2.4" FALSE "v5.3.9")
git clone --single-branch --branch $GB https://github.com/quickreflex/rtl8188eus.git
cd rtl8188eus
echo -e "\e[40;38;5;82m Building driver \e[30;48;5;82m\e[0m"
make all
echo -e "\e[40;38;5;82m Installing driver \e[30;48;5;82m\e[0m"
echo $PASSWORD | sudo -S make install
echo $PASSWORD | sudo -S modprobe 8188eu
echo -e "\e[40;38;5;82mDone :) \e[30;48;5;82mYou can now use your wifi adapter!\e[0m"
cd /home/$USER/Tomomi
rm -d -r rtl8723de
fi

if [[ $DRV == *"RTL8821ce"* ]]; then
GB=$(zenity --list --radiolist --height=100 --width 200 --title="$NAME $VER" --text "The driver $DRV has several branches which do you want to use?" --hide-header --column "$NAME" --column "Item" FALSE "fix-compilation-5.1" FALSE "integrate-v5.2.5_1" FALSE "v5.5.2" FALSE "master")
echo -e "\e[40;38;5;82mDownloading driver\e[30;48;5;82m\e[0m"
git clone --single-branch --branch $GB https://github.com/tomaspinho/rtl8821ce.git
cd rtl8821ce
echo -e "\e[40;38;5;82m Building driver \e[30;48;5;82m\e[0m"
make
echo -e "\e[40;38;5;82m Installing driver \e[30;48;5;82m\e[0m"
echo $PASSWORD | sudo -S make install
echo $PASSWORD | sudo -S modprobe 8821ce
echo -e "\e[40;38;5;82mDone :) \e[30;48;5;82mYou can now use your wifi adapter!\e[0m"
cd /home/$USER/Tomomi
rm -d -r rtl8821ce
fi

if [[ $DRV == *"RTL8723de"* ]]; then
GB=$(zenity --list --radiolist --height=300 --width 300 --title="$NAME $VER" --text "The driver $DRV has several branches which do you want to use?" --hide-header --column "$NAME" --column "Item" FALSE "4.10-down" FALSE "4.11-up" FALSE "4.15-up" FALSE "5.0-up" FALSE "current")
echo -e "\e[40;38;5;82mDownloading driver\e[30;48;5;82m\e[0m"
git clone --single-branch --branch $GB https://github.com/smlinux/rtl8723de.git
cd rtl8723de
echo -e "\e[40;38;5;82m Building driver \e[30;48;5;82m\e[0m"
make
echo -e "\e[40;38;5;82m Installing driver \e[30;48;5;82m\e[0m"
echo $PASSWORD | sudo -S make install
echo $PASSWORD | sudo -S modprobe 8723de
echo -e "\e[40;38;5;82mDone :) \e[30;48;5;82mYou can now use your wifi adapter!\e[0m"
cd /home/$USER/Tomomi
rm -d -r rtl8723de
fi

if [[ $DRV == *"RTL8188fu"* ]]; then
echo -e "\e[40;38;5;82mDownloading driver\e[30;48;5;82m\e[0m"
git clone https://github.com/kelebek333/rtl8188fu
cd rtl8188fu
echo -e "\e[40;38;5;82mBuilding driver\e[30;48;5;82m\e[0m"
make
echo -e "\e[40;38;5;82m Installing driver \e[30;48;5;82m\e[0m"
echo $PASSWORD | sudo -S make install
echo $PASSWORD | sudo -S modprobe rtl8188fu
echo -e "\e[40;38;5;82mDone :) \e[30;48;5;82mYou can now use your wifi adapter!\e[0m"
cd /home/$USER/Tomomi
rm -d -r rtl8188fu
fi
if [[ $DRV == *"RTL88x2bu"* ]]; then
echo -e "\e[40;38;5;82mDownloading driver\e[30;48;5;82m\e[0m"
git clone https://github.com/cilynx/rtl88x2bu.git
cd rtl88x2bu
echo -e "\e[40;38;5;82mBuilding driver\e[30;48;5;82m\e[0m"
make
echo -e "\e[40;38;5;82m Installing driver \e[30;48;5;82m\e[0m"
echo $PASSWORD | sudo -S make install
echo $PASSWORD | sudo -S modprobe 88x2bu
echo -e "\e[40;38;5;82mDone :) \e[30;48;5;82mYou can now use your wifi adapter!\e[0m"
cd /home/$USER/Tomomi
rm -d -r rtl88x2bu
fi
fi

if [[ $? == *"0"* ]]; then
notify-send "Thanks for using $NAME and have a great day!"
exit
fi
bash wireless-simple-solus.sh
