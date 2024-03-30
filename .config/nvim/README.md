# JimiGrunge development environment  configuration

## About this configuration

This configuration is meant to be used on both macOS Sonoma and Ubuntu 18 development machines.
It tries to deal with the main differences between these machines during setup and use.

## Requirements

- `Neovim 0.9 release` version
- `Tmux 3.3a` version
- `Alacrity` terminal emulator (optional)
- Ubuntu or macOS Operating system
  - Other operating systems will need manual install
- A version of bat that is compatible with OS
  - For Ubuntu 18 use `bat` version 0.19.0 download package from GitHub
  - [Bat v0.19.0](https://github.com/sharkdp/bat/releases/tag/v0.19.0)
  - `sudo dpkg -i bat_0.19.0_amd64.deb`

## Install

### Home

Run the `install-dotfiles.sh` script in the bin directory.
This will install all dependencies, backup your existing configuration, and copy this configuration into place.

### Work

The work dev VM uses automated puppet scripts to handle installs, so we need to handle extra software manually.
Copy `nivm` to `~/.config/` directory. `cp nvim ~/.congig/nvim`

Copy individual configuration files to the user home directory.

- `cp config/alacrity/alacrity.yml ~/.config/alacrity/alacrity.yml`
- `cp .alias-ubuntu ~/.alias`
- `cp .tmux-ubuntu.conf ~/.tmux.conf`
- `cp .gitconfig-ubuntu ~/.gitconfig`

### Then

Run `nvim` and wait for the plugins to be installed

You may need to restart Neovim after initial plugin install

**NOTE:** You will notice Treesitter pulling in a bunch of parsers the next time you open Neovim. This is normal, just let it run.

Install more plugins by running `:Mason`

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

## TODO

- Simplify configuration
- Clean up the UI
