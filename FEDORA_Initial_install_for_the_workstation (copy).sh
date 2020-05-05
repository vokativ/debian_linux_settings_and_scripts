##script
#!/bin/bash

#add missing repositories
echo "Направи кафу"
echo 'Adding repositories...'

#update system
    echo 'Updating current install...'
    sudo dnf update && sudo dnf upgrade -y && sudo dnf autoremove -y

#now install my usual packages
    echo 'installing basic software and flathub. This will take a while'
    sudo dnf install -y firefox htop chromium-browser chromium-codecs-ffmpeg-extra vlc cheese neofetch curl python ruby flatpak git

    read - 'Using 1) Gnome or 2) KDE? Need to know for Flatpak integration. 1 or 2: ' kde_or_gnome
    
    if [kde_or_gnome -eq 1]
    then
        sudo dnf install -y plasma-discover-flatpak-backend
    elif [kde_or_gnome -eq 2]
        sudo dnf install -y gnome-software-plugin-flatpak
    else
        echo "Don't be a smart ass"
    fi
    
    
#installing vivaldi
echo 'Installing Vivaldi. If breaks, go to https://vivaldi.com/download/'

    sudo dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
    sudo dnf update && sudo dnf install -y vivaldi-stable
    
#install Calibre
    sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
    
    
#setup my usual flatpak apps
echo 'Installing Flatpak apps...'
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak --noninteractive --assumeyes install flathub com.viber.Viber
    flatpak --noninteractive --assumeyes install flathub com.skype.Client
    flatpak --noninteractive --assumeyes install flathub org.libreoffice.LibreOffice
    flatpak --noninteractive --assumeyes install flathub org.telegram.desktop
    flatpak --noninteractive --assumeyes install flathub org.mozilla.Thunderbird
    flatpak --noninteractive --assumeyes install flathub com.gitlab.librebob.Athenaeum
    flatpak --noninteractive --assumeyes install flathub com.valvesoftware.Steam
    flatpak --noninteractive --assumeyes install flathub com.github.tchx84.Flatseal
    flatpak --noninteractive --assumeyes install flathub org.signal.Signal

#install the snaps for work
echo 'Installing tandem and hub for Github...'
    sudo dnf -y install snapd
    sudo snap install tandem
    sudo snap install hub --classic

#setup permissions for Tandem
echo 'Setting up permissions for tandem'
    snap connect tandem:camera :camera
    snap connect tandem:audio-record :audio-record
    snap connect tandem:pulseaudio :pulseaudio

#Remember to install InSync for Google Drive InSync
    echo 'Download the latest Google Drive sync client at https://www.insynchq.com/downloads'
    nohup firefox https://www.insynchq.com/downloads

#Install the awesome ICE from Peppermint
echo 'If you are not on Peppermint, go to Peppermint OS PPAs and download the latest ICE'
    nohup firefox https://launchpad.net/~peppermintos

#setup the Github and GitLab sync with this folder

    #setup the actual git stuff

    gem install gitlab
    #Create github folder in home and sync the repository
    mkdir ~/github
    cd ~/github
    git clone https://github.com/vokativ/debian_linux_settings_and_scripts.git

    #ask if git credentials are copied
    echo 'Setting up the git sync for backups'
    read -p 'Have you copied the git credentials to setup the sync to Github and GitLab? y(es) or n(o): ' copied_git_credentials

    if [copied_git_credentials == 'yes'] || [copied_git_credentials == 'y']
    then
        #setup the sync with Github and GitLab
        export GIT_USER_NAME=vokativ
        export GIT_REPO_NAME=debian_linux_settings_and_scripts

        #setup the mirrors
        cd ~/github/${GIT_REPO_NAME}/
        git remote set-url origin --add https://gitlab.com/${GIT_USER_NAME}/${GIT_REPO_NAME}.git
        #not working for now git remote set-url origin --add https://bitbucket.org/${GIT_USER_NAME}/${GIT_REPO_NAME}.git
    else
        echo "To setup sync of this backup folder to Github and GitLab at the same time, follow instructions from https://moox.io/blog/keep-in-sync-git-repos-on-github-gitlab-bitbucket/"
        nohup firefox https://moox.io/blog/keep-in-sync-git-repos-on-github-gitlab-bitbucket/
    fi
    
#Background work for GitHub Desktop in Electron
#    # Using Ubuntu
#    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
#    sudo dnf install -y nodejs

#    #install yarn
#    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
#    echo "deb https://nightly.yarnpkg.com/debian/ nightly main" | sudo tee /etc/apt/sources.list.d/yarn.list
#    sudo dnf update && sudo dnf install yarn

#    #remaining dependencies for electron
#    sudo dnf install -y libsecret-1-dev libgconf-2-4
    
echo 'Готово! Finally done'
