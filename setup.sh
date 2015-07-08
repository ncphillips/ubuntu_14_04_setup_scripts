#!/usr/bin/env bash
# Run this script from ~
# Update and Upgrade
sudo apt-get update
sudo apt-get ugrade -y

# Essentials
sudo apt-get install -y vim git built-essentials ubuntu-wallpapers* unity-tweak-tool
sudo apt-get install -y ubuntu-restricted-extras flashplugin-installer
sudo apt-get install -y unrar zip unzip

# Chrome (Checks Processor Type)
if [[ $(getconf LONG_BIT) = "64" ]]
then
	echo "64bit Detected" &&
	echo "Installing Google Chrome" &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&
	sudo dpkg -i google-chrome-stable_current_amd64.deb &&
	rm -f google-chrome-stable_current_amd64.deb
else
	echo "32bit Detected" &&
	echo "Installing Google Chrome" &&
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb &&
	sudo dpkg -i google-chrome-stable_current_i386.deb &&
	rm -f google-chrome-stable_current_i386.deb
fi

# Mongo DB (Latest)
sudo apt-get install mongo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
sudo echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Git Setup
git config --global user.name "Nolan Phillips"
git config --global user.email "ncphillips.19@gmail.com"

# NVM & Latest io.js
curl https://raw.githubusercontent.com/creationix/nvm/v0.23.3/install.sh | bash
nvm install iojs
echo "nvm use iojs" >> ~/.profile

# io.js global modules
npm install -g grunt-cli
npm install -g bunyan
npm install -g docco

# Vim Setup
git clone https://github.com/ncphillips/vimrc temp_vim
mv temp_vim * .
rmdir temp_vim

# Directories
mkdir ~/Projects
sudo rm -rf ~/Music
sudo rm -rf ~/Movies
sudo rm -rf ~/Templates
sudo rm -rf ~/Pictures

# Remove Shotwell TODO

sudo apt-get remove --purge -y thunderbird* libreoffice* rhythmbox* 
sudo apt-get remove -y unity-webapps-common

# Disable Shopping Suggestions
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"

echo "Cleaning Up" &&
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean
