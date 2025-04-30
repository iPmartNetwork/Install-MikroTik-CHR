#!/bin/bash
# Modernized and optimized version of the Backhaul management script
# Author: Original by AnonyIdentity, enhancements by ChatGPT

set -euo pipefail

# ─────────────────────────────────────────────────────────────────────────────
# Constants and Variables
# ─────────────────────────────────────────────────────────────────────────────
SCRIPT_VERSION="v0.7.0"
CONFIG_DIR="/root/backhaul-core"
SERVICE_DIR="/etc/systemd/system"
DEST_DIR="/usr/bin"
SCRIPT_NAME="backhaul"

# Colors
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
MAGENTA="\e[95m"
CYAN="\e[96m"
RESET="\e[0m"

# ─────────────────────────────────────────────────────────────────────────────
# Utility Functions
# ─────────────────────────────────────────────────────────────────────────────
press_key() {
  read -n 1 -s -r -p "Press any key to continue..."
  echo
}

colorize() {
  local color="$1"; shift
  local text="$1"; shift
  local style="${1:-normal}"
  local style_code=""
  [[ "$style" == "bold" ]] && style_code="\e[1m"
  echo -e "${style_code}${!color}${text}${RESET}"
}

is_installed() {
  command -v "$1" &> /dev/null
}

# ─────────────────────────────────────────────────────────────────────────────
# Dependency Installers
# ─────────────────────────────────────────────────────────────────────────────
install_package() {
  local pkg="$1"
  if ! is_installed "$pkg"; then
    if is_installed apt-get; then
      apt-get update && apt-get install -y "$pkg"
    else
      colorize RED "Error: Package manager not supported. Install $pkg manually."
      exit 1
    fi
  fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Logo and Info
# ─────────────────────────────────────────────────────────────────────────────
display_logo() {
  echo -e "${CYAN}"
  cat << "EOF"
  ____________________________________________________________________________
      ____                             _     _
 ,   /    )                           /|   /                                 
-----/____/---_--_----__---)__--_/_---/-| -/-----__--_/_-----------__---)__--
 /   /        / /  ) /   ) /   ) /    /  | /    /___) /   | /| /  /   ) /   ) 
_/___/________/_/__/_(___(_/_____(_ __/___|/____(___ _(_ __|/_|/__(___/_/____

             Lightning-fast reverse tunneling solution
EOF
  echo -e "${RESET}${GREEN}Script Version: ${YELLOW}${SCRIPT_VERSION}${RESET}"
  [[ -f "${CONFIG_DIR}/backhaul_premium" ]] && \
    echo -e "${GREEN}Core Version: ${YELLOW}$(${CONFIG_DIR}/backhaul_premium -v)${RESET}"
  echo -e "${GREEN}Telegram: ${YELLOW}@anony_identity${RESET}\n"
}

# ─────────────────────────────────────────────────────────────────────────────
# Backhaul Core Management
# ─────────────────────────────────────────────────────────────────────────────
download_backhaul_core() {
  local arch url tmp_dir

  [[ -f "${CONFIG_DIR}/backhaul_premium" ]] && return

  arch=$(uname -m)
  case "$arch" in
    x86_64) url="https://github.com/Musixal/Backhaul/releases/download/v0.6.5/backhaul_linux_amd64.tar.gz";;
    arm64|aarch64) url="https://github.com/Musixal/Backhaul/releases/download/v0.6.5/backhaul_linux_arm64.tar.gz";;
    *) colorize RED "Unsupported architecture: $arch" && exit 1;;
  esac

  tmp_dir=$(mktemp -d)
  curl -sSL -o "$tmp_dir/backhaul.tar.gz" "$url"
  mkdir -p "$CONFIG_DIR"
  tar -xzf "$tmp_dir/backhaul.tar.gz" -C "$CONFIG_DIR"
  chmod +x "${CONFIG_DIR}/backhaul_premium"
  rm -rf "$tmp_dir"
  colorize GREEN "Backhaul core installed."
}

remove_backhaul_core() {
  if find "$CONFIG_DIR" -type f -name "*.toml" | grep -q .; then
    colorize RED "Remove all tunnel configs before removing Backhaul core."
    return
  fi
  rm -rf "$CONFIG_DIR"
  colorize GREEN "Backhaul core removed."
}

# ─────────────────────────────────────────────────────────────────────────────
# Tunnel Configuration Placeholders
# ─────────────────────────────────────────────────────────────────────────────
configure_tunnel() {
  colorize YELLOW "Tunnel configuration logic coming soon..."
  press_key
}

manage_tunnels() {
  colorize YELLOW "Tunnel management interface coming soon..."
  press_key
}

check_tunnel_status() {
  colorize YELLOW "Status checker will be implemented..."
  press_key
}

optimize_system() {
  colorize YELLOW "System/network optimization pending..."
  press_key
}

update_script_logic() {
  colorize YELLOW "Script updater coming soon..."
  press_key
}

# ─────────────────────────────────────────────────────────────────────────────
# Menu
# ─────────────────────────────────────────────────────────────────────────────
show_menu() {
  clear
  display_logo
  echo -e "${MAGENTA}══════════════════════════════════════════════${RESET}"
  echo -e "${GREEN} 1.${RESET} Configure a new tunnel"
  echo -e "${GREEN} 2.${RESET} Manage existing tunnels"
  echo -e "${GREEN} 3.${RESET} Check tunnel statuses"
  echo -e "${GREEN} 4.${RESET} Optimize system and network"
  echo -e "${GREEN} 5.${RESET} Install or Update Backhaul Core"
  echo -e "${GREEN} 6.${RESET} Update script"
  echo -e "${GREEN} 7.${RESET} Remove Backhaul Core"
  echo -e "${GREEN} 0.${RESET} Exit"
  echo -e "${MAGENTA}══════════════════════════════════════════════${RESET}\n"
}

main_loop() {
  while true; do
    show_menu
    read -rp "Enter your choice [0-7]: " choice
    case "$choice" in
      1) configure_tunnel;;
      2) manage_tunnels;;
      3) check_tunnel_status;;
      4) optimize_system;;
      5) download_backhaul_core;;
      6) update_script_logic;;
      7) remove_backhaul_core;;
      0) exit 0;;
      *) colorize RED "Invalid option";;
    esac
  done
}

# ─────────────────────────────────────────────────────────────────────────────
# Entry Point
# ─────────────────────────────────────────────────────────────────────────────
[[ $EUID -ne 0 ]] && colorize RED "This script must be run as root" && exit 1
install_package unzip
install_package jq
main_loop
