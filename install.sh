#!/bin/bash

# Define text colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# check if any command was successful or not
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}${BOLD}$1${RESET}"
    else
        echo -e "${RED}${BOLD}Error:${RESET} $2"
        exit 1
    fi
}

# check if pacman is installed
check_pacman() {
    if ! command -v pacman &> /dev/null; then
        echo -e "${RED}${BOLD}Error:${RESET} pacman is not installed on this system."
        echo -e "Please install pacman and try again."
        exit 1
    else
        echo -e "${GREEN}${BOLD}Pacman is installed.${RESET} Proceeding further..."
    fi
}

# Function to check if yay or paru is installed
check_aur_helper() {
    if command -v yay &> /dev/null; then
        echo -e "${GREEN}${BOLD}An AUR helper yay is already installed.${RESET}"
    elif command -v paru &> /dev/null; then
        echo -e "${GREEN}${BOLD}An AUR helper paru is already installed.${RESET}"
    else
        return 1
    fi
}

# Warning message
echo -e "${RED}${BOLD}WARNING:${RESET}This script is going to make changes on your system!!! Don't blindly run this script without knowing what it entails!!"
echo -e "${CYAN}${BOLD}Please read and understand the script before proceeding.${RESET}"
read -rp "$(echo -e "${CYAN}${BOLD}Do you want to continue? (yes/no):${RESET} ")" choice
if [[ ! $choice =~ ^[Yy](es)?$ ]]; then
    echo -e "${RED}${BOLD}Script terminated.${RESET}"
    exit 1
fi

# Check if pacman is installed
check_pacman

# Check if yay or paru is already installed
if check_aur_helper; then
    # Determine which AUR helper is installed
    aur_helper=$(command -v yay || command -v paru)
else
    # AUR helper options
    aur_helpers=("yay" "paru")

    # Prompt user to choose AUR helper (default is yay)
    echo -e "${BOLD}Choose AUR helper (default is yay):${RESET}"
    select aur_helper in "${aur_helpers[@]}"; do
        case $aur_helper in
            "yay"|"paru")
                break
                ;;
            *)
                echo -e "${RED}${BOLD}Invalid option.${RESET} Please choose again."
                ;;
        esac
    done

    # Set default AUR helper to yay
    aur_helper=${aur_helper:-yay}

    # Install the AUR helper
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/$aur_helper.git
    cd $aur_helper
    makepkg -si
    cd ..
    check_status "$aur_helper is installed. Proceeding further..." "Failed to install $aur_helper."
fi

echo -e "Updating the system..."
$aur_helper -Syu --noconfirm

# Install Zsh
echo -e "${GREEN}${BOLD}Installing Zsh...${RESET}"
$aur_helper -S --noconfirm zsh

# Change the default shell to Zsh
echo -e "${GREEN}${BOLD}Changing default shell to Zsh...${RESET}"
chsh -s /bin/zsh
touch ~/.zshrc

# List of packages to install
packages=(
    jq
    ripgrep
    alsa-utils
    sof-firmware
    pipewire
    wireplumber
    pipewire-alsa
    pipewire-pulse
    brightnessctl
    blueman
    hyprland
    hyprlock
    waybar
    xdg-utils
    xdg-user-dirs
    rofi-lbonn-wayland-git
    kitty
    neovim
    wl-clipboard
    thunar
    thunar-volman
    tumbler
    gvfs
    thefuck
    grim
    slurp
    swayimg
    gtk3
    qt5-base
    qt6-base
    libdbusmenu-glib
    libdbusmenu-gtk3
    gtk-layer-shell
    dunst
    gtk3
    playerctl
    ffmpeg
    vlc
    gammastep
    lsd
    starship
    fastfetch
    cava
    btop
    swww
    waypaper
    firefox
    ttf-jetbrains-mono-nerd
    ttf-victor-mono-nerd
    adobe-source-han-sans-jp-fonts
    otf-opendyslexic-nerd
    nwg-look
    gradience
    catppuccin-gtk-theme-mocha
)

# Install the packages
echo -e "${GREEN}${BOLD}Installing the required packages...${RESET}"
$aur_helper -S --noconfirm "${packages[@]}"
check_status "Packages installed successfully." "Failed to install packages."

# Update user directories
echo -e "${GREEN}${BOLD}Updating user directories...${RESET}"
xdg-user-dirs-update

# Install eww widgets
echo -e "${GREEN}${BOLD}Installing eww widgets...${RESET}"
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features=wayland
check_status "Eww build successful." "Failed to build Eww."
cd target/release
chmod +x ./eww
mkdir -p $HOME/.local/bin
cp eww $HOME/.local/bin
cd $HOME
echo -e "${GREEN}${BOLD}Eww widgets installed successfully.${RESET}"


echo -e "${GREEN}${BOLD}Installation complete :-)\n Please reboot your system ${RESET}"
