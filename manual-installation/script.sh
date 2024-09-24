#!/bin/bash

# Script to install XRDP with H.264 support on Ubuntu

# Function to print messages
function print_message() {
    echo -e "\n===== $1 =====\n"
}

# Step 1: Update system and install Ubuntu Desktop if not already installed
print_message "Updating system and installing Ubuntu Desktop"
sudo apt update
sudo apt install -y ubuntu-desktop

# Step 2: Add the XRDP PPA repository and update the system
print_message "Adding XRDP PPA repository and updating package list"
sudo apt-add-repository -y ppa:saxl/xrdp-egfx
sudo apt update

# Step 3: Install XRDP with H.264 support
print_message "Installing XRDP with H.264 support"
sudo apt install -y xrdp-egfx xorgxrdp-egfx

# Step 4: Optionally install PulseAudio for sound redirection
print_message "Installing PulseAudio module for XRDP (optional)"
sudo apt install -y pulseaudio-module-xrdp

# Step 5: Enable and start the XRDP service
print_message "Enabling and starting XRDP service"
sudo systemctl enable xrdp.service
sudo systemctl start xrdp.service

# Step 6: Open port 3389 for remote desktop connections
print_message "Opening port 3389 for remote desktop connections"
sudo ufw allow 3389
sudo ufw status

# Step 7: Final message
print_message "Installation completed. Check /var/log/xrdp.log to confirm H.264 or RFX codec usage."
echo -e "To verify the codec, check the logs for either:\n\
  - rdp_encoder_create: starting gfx rfx pro codec session\n\
  - xrdp_encoder_create: starting h264 codec session gfx\n"
