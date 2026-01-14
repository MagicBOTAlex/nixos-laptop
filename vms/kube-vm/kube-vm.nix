{ pkgs, ... }: { imports = [ ./../../modules/getNvim.nix ]; environment.systemPackages = [ neovim git wget curl busybox ]; }
