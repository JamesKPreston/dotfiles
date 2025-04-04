#!/usr/bin/env bash

set -e

GREEN="\033[0;32m"
NC="\033[0m"

echo -e "${GREEN}Installing Linuxbrew...${NC}"
if ! command -v brew &> /dev/null; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
fi

# Set up brew in the current shell
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo -e "${GREEN}Installing required packages...${NC}"
brew install stow git zsh starship nodenv

echo -e "${GREEN}Installing Oh My Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Backup the default zshrc before stowing
if [ -f "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%s)"
fi

echo -e "${GREEN}Installing Node via nodenv...${NC}"
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
nodenv install 20.11.1
nodenv global 20.11.1

echo -e "${GREEN}Setting up Starship config directory...${NC}"
mkdir -p "$HOME/.config"

echo -e "${GREEN}Symlinking dotfiles with stow...${NC}"
cd "$HOME/dotfiles"
stow */

echo -e "${GREEN}✅ Setup complete! Restart your shell to apply all changes.${NC}"
