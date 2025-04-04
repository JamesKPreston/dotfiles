# 🛠️ Dotfiles

My personal dotfiles for setting up a Linux development environment using:

- Linuxbrew
- GNU Stow
- nodenv
- npm
- Oh My Zsh
- Starship prompt

## 🚀 Bootstrap Installation

Clone the repo and run the installation script:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x bootstrap.sh
./bootstrap.sh
```

## 📁 Folder Structure

```
dotfiles/
├── zsh/          # .zshrc
├── starship/     # starship.toml
├── git/          # .gitconfig
├── nvim/         # (add later if needed)
└── bootstrap.sh  # Setup script
```

## 🔐 Notes

- Secrets or machine-specific config should be kept in dotfiles-local/ (excluded from Git).
