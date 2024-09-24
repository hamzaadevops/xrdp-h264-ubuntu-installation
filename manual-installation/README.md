# Manual Installation of XRDP H264 on Ubuntu
- **Step 1**: Install Ubuntu Desktop if not already Installed;
```bash
sudo apt update
sudo apt install ubuntu-desktop
```
- **Step 2**: Setup the XRDP Repo to your system and update the system
```bash
apt-add-repository ppa:saxl/xrdp-egfx
sudo apt update
```
- **Step 3**: Install XRDP with h264 supported features;
```bash
apt install xrdp-egfx xorgxrdp-egfx
#optional
apt install pulseaudio-module-xrdp
```
- **Step 4**: Confirm the Installation;
```bash
sudo systemctl enable xrdp.service && sudo systemctl start xrdp.service 
```
- **Step 5**: Open Port 3389 and connect to you server using ubuntu and confirm the presence of h264.
```bash
sudo ufw allow 3389
sudo ufw status
```
- **Step 6**: what codec is used you will see in /var/log/xrdp.log. Look for a line that says
```bash
rdp_encoder_create: starting gfx rfx pro codec session
```
or 
```bash
xrdp_encoder_create: starting h264 codec session gfx
```
