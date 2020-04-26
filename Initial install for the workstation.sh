#add missing repositories
echo 'Adding repositories...'

#update system
echo 'Updating current install...'
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

#now install my usual packages
echo 'installing bassic software and flathub...'
sudo apt install firefox htop chromium-browser chromium-codecs-ffmpeg-extra vlc cheese flatpak gnome-software-plugin-flatpak git

#installing vivaldi
echo 'Installing Vivaldi. If breaks, go to https://vivaldi.com/download/'

wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
sudo apt update && sudo apt install vivaldi-stable

#setup my usual flatpak apps
echo 'Installing Flatpak apps...'
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.viber.Viber
flatpak install flathub com.skype.Client
flatpak install flathub org.libreoffice.LibreOffice
flatpak install flathub org.telegram.desktop
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub com.gitlab.librebob.Athenaeum
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.github.tchx84.Flatseal

#install the snaps for work
echo 'Installing tandem and hub for Github...'
sudo snap install tandem
sudo snap install hub --classic

#setup permissions for Tandem
echo 'Setting up permissions for tandem'
snap connect tandem:camera :camera
snap connect tandem:audio-record :audio-record
snap connect tandem:pulseaudio :pulseaudio

#Remember to install InSync for Google Drive InSync
echo 'Download the latest Gogole Drive sync client at https://www.insynchq.com/downloads'

#Install the awesome ICE from Peppermint
echo 'If you are not on Peppermint, go to Peppermint OS PPAs and download the latest ICE'
firefox https://launchpad.net/~peppermintos

#setup the Github and GitLab sync with this folder
echo "To setup sync of this backup folder to Github and GitLab at the same time, follow instructions from https://moox.io/blog/keep-in-sync-git-repos-on-github-gitlab-bitbucket/"
echo "Get ready with your Github and GitLab tokens"
#git remote set-url origin --add https://gitlab.com/vokativ/debian_linux_settings_and_scripts.git

