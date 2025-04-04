#!/usr/bin/env bash

set -e

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

# Detect sudo
HAS_SUDO="no"
if command -v sudo &>/dev/null && sudo -n true 2>/dev/null; then
  HAS_SUDO="yes"
fi

echo -e "${GREEN}Installing Homebrew...${NC}"

if ! command -v brew &> /dev/null; then
  if [ "$HAS_SUDO" = "yes" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  else
    echo -e "${RED}No sudo detected. Installing Homebrew to ~/.homebrew (this is slower)...${NC}"
    git clone https://github.com/Homebrew/brew ~/.homebrew
    echo 'eval "$(~/.homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    mkdir -p ~/.homebrew/bin
    eval "$(~/.homebrew/bin/brew shellenv)"
  fi
fi

echo -e "${GREEN}Installing packages...${NC}"
brew install stow git zsh starship nodenv

echo -e "${GREEN}Installing Oh My Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Backup zshrc created by Oh My Zsh
if [ -f "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%s)"
fi

echo -e "${GREEN}Installing Node.js via nodenv...${NC}"
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
nodenv install 20.11.1
nodenv global 20.11.1

echo -e "${GREEN}Creating Starship config directory...${NC}"
mkdir -p "$HOME/.config"

echo -e "${GREEN}Linking dotfiles with Stow...${NC}"
cd "$HOME/dotfiles"
stow */

echo -e "${GREEN}✅ Environment setup complete! Restart your shell or run 'exec zsh'.${NC}"
