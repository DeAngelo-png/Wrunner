#!/bin/bash
set -e

echo "Detecting package manager..."

if command -v pacman &> /dev/null; then
  PM="pacman"
  INSTALL="sudo pacman -S --noconfirm --needed"
elif command -v apt &> /dev/null; then
  PM="apt"
  INSTALL="sudo apt install -y"
elif command -v dnf &> /dev/null; then
  PM="dnf"
  INSTALL="sudo dnf install -y"
elif command -v zypper &> /dev/null; then
  PM="zypper"
  INSTALL="sudo zypper install -y"
else
  echo "Unsupported or unknown package manager."
  echo "Please install these packages manually: xwinwrap, mpv, ffmpeg, feh, imagemagick, xdotool, socat"
  exit 1
fi

echo "Using package manager: $PM"

echo "Updating package lists..."
if [ "$PM" = "apt" ]; then
  sudo apt update
elif [ "$PM" = "pacman" ]; then
  sudo pacman -Sy
elif [ "$PM" = "dnf" ]; then
  sudo dnf check-update || true
elif [ "$PM" = "zypper" ]; then
  sudo zypper refresh
fi

echo "Installing dependencies..."

if [ "$PM" = "pacman" ]; then
  $INSTALL xwinwrap mpv ffmpeg feh imagemagick xdotool socat
elif [ "$PM" = "apt" ]; then
  $INSTALL x11-xserver-utils mpv ffmpeg feh imagemagick xdotool socat
elif [ "$PM" = "dnf" ]; then
  $INSTALL xwinwrap mpv ffmpeg feh ImageMagick xdotool socat
elif [ "$PM" = "zypper" ]; then
  $INSTALL xwinwrap mpv ffmpeg feh ImageMagick xdotool socat
fi

echo "Installation complete."

echo "Note: On some distros, xwinwrap may not be available in repos."
echo "If missing, consider building it from source: https://github.com/mmhobi7/xwinwrap"

echo "DONE..."
