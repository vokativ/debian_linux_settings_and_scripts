##script
#!/bin/bash

#As instructed by Google on https://cloud.google.com/solutions/chrome-desktop-remote-on-compute-engine
#This uses Cinammon, but you can also setup XFCE

#download the Debian Linux Chrome Remote Desktop installation package
    echo "Downloading Chrome Remote Desktop"
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb

#Update the package manager and install CRD and dependencies
    echo "Installing Chrome Remote Desktop"
    sudo apt update
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb
    sudo apt install --assume-yes --fix-broken


##XFCE DESKTOP INSTALLATION ###################################################################################

##install the Xfce desktop environment and basic desktop components
#      echo "Installing XFCE base"
#    sudo DEBIAN_FRONTEND=noninteractive \
#        apt install --assume-yes xfce4 desktop-base

##Configure Chrome Remote Desktop to use Xfce by default
#   echo "Configuring Chrome Remote Desktop to use Xfce by default"
#    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

##Xfce's default screen locker is Light Locker, which doesn't work with Chrome Remote Desktop. (The screen locker displays a blank screen and cannot be unlocked). Therefore, install XScreenSaver as an alternative
#     echo "Installing Xscreensaver since Ligh Locker doesn't work well with CRD"
#    sudo apt install --assume-yes xscreensaver

##Optionally, install the full suite of Linux desktop applications, including the Firefox browser, LibreOffice office application suite, and the Evince PDF viewer##
#      echo "Installing the full suite of XFCE applications"
#    sudo apt install --assume-yes task-xfce-desktop

## FINAL OF XFCE DESKTOP INSTALLATION ###################################################################################

##CINAMMON DESKTOP INSTALLATION ###################################################################################

#install the Cinnamon desktop environment and basic desktop components
    echo "Installing the Cinnamon desktop environment and basic desktop components"
    sudo DEBIAN_FRONTEND=noninteractive \
        apt install --assume-yes cinnamon-core desktop-base

#Set your Chrome Remote Desktop session to use Cinnamon in 2D mode (which does not use 3D graphics acceleration) by default
    echo "Setting your Chrome Remote Desktop session to use Cinnamon in 2D mode (which does not use 3D graphics acceleration) by default"
    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/cinnamon-session-cinnamon2d" > /etc/chrome-remote-desktop-session'

#Optionally, install the full suite of Linux desktop applications, including the Firefox browser, the LibreOffice office application suite, and the Evince PDF viewer
    echo "Installing full suite of Cinnamon applications"
    sudo apt install --assume-yes task-cinnamon-desktop

##FINAL CINAMMON DESKTOP INSTALLATION ###################################################################################

#Disable the display manager service on your instance. There is no display connected to your instance, so the display manager service won't start.
    echo "Disabling the display manager service on your instance. There is no display connected to your instance, so the display manager service won't start."
    sudo systemctl disable lightdm.service
    
#install the Chrome browser since CRD works best when it's installed
    echo "Installing the Chrome browser since CRD works best when it's installed"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    sudo dpkg --install google-chrome-stable_current_amd64.deb
    sudo apt install --assume-yes --fix-broken

#Download the script to setup Nemanja's workstation in full
    echo "Downloading the workstation setup script. Run it after you finish this"
    wget https://raw.githubusercontent.com/vokativ/debian_linux_settings_and_scripts/master/Initial_install_for_the_workstation.sh
    echo "Go to https://cloud.google.com/solutions/chrome-desktop-remote-on-compute-engine#configuring_and_starting_the_chrome_remote_desktop_service and follow the steps to authorize machine access with this machine. DO NOT CLOSE THIS SESSION"

#To avoid getting locked out of the remote desktop, you can set a password for your user
    echo "Set a password to avoid getting locked out of the machine. REMEMBER IT"
    sudo passwd $(whoami)

#If you have an ultra high-resolution monitor, you might find that the default maximum remote desktop size of 1600 x 1200 is too small. If so, you can increase it to the resolution of your monitor.
    echo "Increasing the resolution to 1920x1080 for CRD"
    echo "export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1600x1200,1920x1080,3840x2560" \
        >> ~/.profile
#Restart service
    sudo systemctl restart chrome-remote-desktop

