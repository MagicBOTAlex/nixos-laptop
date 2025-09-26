{ config, pkgs, inputs, ... }:

let
in
{
  boot.loader.grub = {
    minegrub-world-sel = {
      enable = true;
      customIcons = [{
        name = "nixos";
        lineTop = "NixOS W";
        lineBottom = "Survival Mode, No Cheats, Version: 23.11";
        # Icon: you can use an icon from the remote repo, or load from a local file
        imgName = "nixos";
        # customImg = builtins.path {
        #   path = ./nixos-logo.png;
        #   name = "nixos-img";
        # };
      }];
    };
  };

  boot.plymouth = {
    enable = true;
    theme = "mc";
    themePackages = [
      inputs.minemouth.packages.${pkgs.system}.plymouth-minecraft-theme
    ];
  };
  hardware.enableRedistributableFirmware = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "quiet" "splash" ];
  # boot.consoleLogLevel = 0;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = [ "nodev" ]; # UEFI: don’t write to a disk MBR
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
}

