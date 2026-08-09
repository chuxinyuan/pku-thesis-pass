#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y fonts-noto-cjk fonts-arphic-ukai

# Install Microsoft core fonts
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections
sudo apt install -y ttf-mscorefonts-installer

# Install FandolFang and ZhuqueFangsong font
sudo mkdir -p /usr/local/share/fonts
curl -sSL https://mirrors.aliyun.com/CTAN/fonts/fandol/FandolFang-Regular.otf -o /tmp/FandolFang-Regular.otf
sudo cp /tmp/FandolFang-Regular.otf /usr/local/share/fonts/
curl -sSL https://mirrors.aliyun.com/CTAN/fonts/lxgw-fonts/LXGWZhuqueFangsong-Regular.ttf -o /tmp/LXGWZhuqueFangsong-Regular.ttf
sudo cp /tmp/LXGWZhuqueFangsong-Regular.ttf /usr/local/share/fonts/
sudo fc-cache -fv
