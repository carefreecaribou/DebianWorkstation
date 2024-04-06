#!/bin/sh

if [ -d ~/Development/Debain12PentestWorkstation/ ]; 
then
    echo "Playbook is already local. Cannot safely autoprovision. Delete ~/Development/Debain12PentestWorkstation and rerun, or manually run the playbook to continue.";
    exit 1;
fi

# Update Packages
sudo apt update && sudo NEEDRESTART_MODE=a apt-get -y upgrade
sudo apt install -y git python3-pip ansible python3-jinja2

# Make Development Folder and Clone the Repo
mkdir -p ~/Development/Debain12PentestWorkstation;
git clone https://github.com/carefreecaribou/DebianWorkstation.git ~/Development/Debain12PentestWorkstation;
[ -f ~/provision-config.yml ] && mv ~/provision-config.yml ~/Development/Debain12PentestWorkstation/config.yml;
cd ~/Development/Debain12PentestWorkstation

# Run the Playbook
ansible-galaxy install -r requirements.yml
echo "remove_autostart: true" >> config.yml
mkdir -p ~/.config/autostart
contents='[Desktop Entry]
Type=Application
Exec=gnome-terminal -- bash -c "cd ~/Development/Debain12PentestWorkstation && ansible-playbook main.yml --ask-become-pass; bash"
Hidden=false
X-GNOME-Autostart-enabled=true
Name[en_US]=AnsibleAutoConfig
Name=AnsibleAutoConfig'
echo "$contents" > ~/.config/autostart/ansible.desktop
sudo reboot now