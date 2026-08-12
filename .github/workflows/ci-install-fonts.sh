#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y fonts-noto-cjk fonts-arphic-ukai

# poppler-utils provides pdftotext (used by blind-mode and longtable/bib checks)
sudo apt install -y poppler-utils

# Install Liberation fonts (metric-compatible with Times New Roman / Arial)
sudo apt install -y fonts-liberation

# Install FandolFang and ZhuqueFangsong font
sudo mkdir -p /usr/local/share/fonts
curl -sSL https://mirrors.aliyun.com/CTAN/fonts/fandol/FandolFang-Regular.otf -o /tmp/FandolFang-Regular.otf
sudo cp /tmp/FandolFang-Regular.otf /usr/local/share/fonts/
curl -sSL https://mirrors.aliyun.com/CTAN/fonts/lxgw-fonts/LXGWZhuqueFangsong-Regular.ttf -o /tmp/LXGWZhuqueFangsong-Regular.ttf
sudo cp /tmp/LXGWZhuqueFangsong-Regular.ttf /usr/local/share/fonts/
sudo fc-cache -fv
