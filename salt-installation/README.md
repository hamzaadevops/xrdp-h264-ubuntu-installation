# Automated XRDP Installation on Ubuntu Using SaltStack
This guide provides step-by-step instructions to automate the installation of XRDP with H.264 support on Ubuntu servers using SaltStack. The Salt states allow concurrent deployment of XRDP across multiple minions, simplifying large-scale deployments.

## Introduction to SaltStack Deployment
SaltStack is a powerful configuration management and automation tool that allows you to manage and configure multiple servers (minions) from a single Salt master. This repository includes a Salt state file that will:

- Add the `saxl/xrdp-egfx` PPA repository to your Ubuntu servers.
- Install XRDP with H.264 support and optional audio redirection using PulseAudio.
- Ensure the XRDP service is enabled and started.
- Open port 3389 for remote desktop connections.

## Steps to Apply the Salt State
### 1. Clone the Repository:
Clone this repository onto your Salt master node:
```bash
git clone https://github.com/hamzaadevops/xrdp-h264-ubuntu-installation
cd xrdp-h264-ubuntu-installation
```

### 2. Copy the Salt State Files:
Copy the `xrdp_egfx.sls` file to your Salt state directory (e.g., `/srv/salt/`):
```bash
sudo cp salt-installation/states/ubuntu-desktop.sls /srv/salt/
sudo cp salt-installation/states/xrdp_egfx.sls /srv/salt/
```
### 3. Apply the State to Minions:
Run the following command to apply the XRDP installation state to all minions or specific minions:
```bash
sudo salt -G 'os:Ubuntu' state.apply xrdp_egfx
```
### 4. Verify Installation:
After the state is applied, you can verify XRDP installation on all minions by running:
```bash
sudo salt -G 'os:Ubuntu' cmd.run 'dpkg -l | grep xrdp'
```
## Configurations for Multi-Minions
- **Parallel Installation**: SaltStack allows concurrent installation on multiple minions. You can target specific minions or groups using Salt grains or node groups.

- **Customizing States**: You can modify the xrdp_egfx.sls file to customize package versions or additional configurations based on your environment.

**For example**, if you want to install additional desktop environments or services alongside XRDP, you can append them to the state file.

