#!/bin/bash
set -e

echo "🔧 Installing ubuntu-desktop-minimal + build dependencies..."
sudo apt update
sudo apt install -y ubuntu-desktop-minimal gnome-session gdm3 xrdp xorgxrdp \
git autoconf libtool pkg-config gcc g++ make libssl-dev libpam0g-dev \
libjpeg-dev libx11-dev libxfixes-dev libxrandr-dev flex bison libxml2-dev intltool xsltproc \
xutils-dev python3-libxml2 g++ xutils libfuse-dev libmp3lame-dev nasm libpixman-1-dev \
xserver-xorg-dev libjson-c-dev libsndfile1-dev libspeex-dev libspeexdsp-dev libpulse-dev \
libpulse0 autopoint libturbojpeg libfdk-aac-dev libopus-dev libgbm-dev libx264-dev libepoxy-dev

echo "🧹 Cleaning up old xrdp/xorgxrdp source folders if they exist..."
rm -rf ~/xrdp ~/xorgxrdp

echo "🧱 Cloning and building xrdp with H.264 support..."
cd ~
git clone https://github.com/neutrinolabs/xrdp.git
cd xrdp
./bootstrap
./configure --enable-x264
make -j$(nproc)
sudo make install
sudo systemctl enable xrdp

echo "🧱 Cloning and building xorgxrdp..."
cd ~
git clone https://github.com/neutrinolabs/xorgxrdp.git
cd xorgxrdp
./bootstrap
./configure
make -j$(nproc)
sudo make install

echo "🔐 Allowing non-console users to run Xorg..."
echo "allowed_users=anybody" | sudo tee /etc/X11/Xwrapper.config

echo "🚫 Disabling Wayland in GDM (GNOME)..."
sudo sed -i 's/^#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
sudo sed -i 's/^WaylandEnable=true/WaylandEnable=false/' /etc/gdm3/custom.conf
sudo systemctl restart gdm3

echo "🔁 Restarting xrdp services..."
sudo systemctl restart xrdp xrdp-sesman