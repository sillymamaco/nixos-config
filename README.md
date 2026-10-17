# My NixOS Configuration

My personal NixOS setup using flakes. 

## Structure
- `flake.nix`: The main entry point for the configuration.
- `hosts/`: Host-specific configurations (e.g., tuf).
- `modules/`: Custom system and user modules.
- `home/`: Home Manager configurations (Zsh, Starship, etc.).

## Note
This repository was an experiment to learn the Nix language and declarative system management. While I currently daily-drive Arch Linux, I keep this here as a reference for functional package management and reproducible builds.
