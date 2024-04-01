# Ansible Configuration for Debian Pentest Workstation
This is my personal playbook for a Debian 12 Penetration Testing Workstation. It is designed to be ran locally on the machine being provisioned, or remotely. 

# Initialization Steps
On a newly installed image:
- Connect to a wireless network.
- To overwrite the defaults, save a confiration file as ~/provision-config.yml. To download the current default config for overriding it:

```bash
curl -fsSL https://raw.githubusercontent.com/carefreecaribou/DebianWorkstation/main/default.config.yml -o provision-config.yml
```
- Be sure to include your burpsuite pro license key in the `provision_config.yml` file.
  - You can use `sed -i "s/<key>/$(sed 's:/:\\/:g' ~/Downloads/Burp_Suite_Professional_-_licensed_to_ORG.txt )/" provision-config.yml`
- If you autoprovision, the `remove_autostart` variable is appended to your config file to prevent running the autoprovision specific tasks.
- Open a terminal, curl the `.autoprovision.sh` script and pipe to bash to autoprovision the system:
```bash
curl -fsSL https://raw.githubusercontent.com/carefreecaribou/DebianWorkstation/main/.autoprovision.sh | bash
```