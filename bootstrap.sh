#!/usr/bin/env bash

set -e

GREEN="\033[0;32m"
NC="\033[0m"

echo -e "${GREEN}Installing Linuxbrew...${NC}"
if ! command -v brew &> /dev/null; then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.bashrc"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

echo -e "${GREEN}Installing required packages...${NC}"
brew install stow git zsh starship nodenv

echo -e "${GREEN}Installing NPM (via nodenv)...${NC}"
eval "$(nodenv init -)"
nodenv install 20.11.1
nodenv global 20.11.1

echo -e "${GREEN}Installing Oh My Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo -e "${GREEN}Configuring Starship...${NC}"
mkdir -p ~/.config
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

echo -e "${GREEN}Cloning dotfiles and stowing...${NC}"
cd "$HOME/dotfiles"
stow */

echo -e "${GREEN}All set! Restart your shell to start using Zsh + Starship :)${NC}"
