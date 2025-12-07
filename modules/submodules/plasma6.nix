{ pkgs, lib, ... }:
let toggles = import ./../../toggles.nix;
in
{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  } // (lib.optionalAttrs (toggles.mineboot.enable or false) {
    theme = "minesddm";
  });
  # In toggles.nix if wezterm enabled, then disable konsole
  environment.plasma6.excludePackages =
    lib.optional (!toggles.wezterm.enable) (with pkgs.kdePackages;
    [ konsole ]);

  services.desktopManager.plasma6.enable = true;

  imports = [ ./../submodules/chineseInput.nix ];
}
