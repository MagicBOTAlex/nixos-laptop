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

  services.desktopManager.plasma6.enable = true;

  imports = [ ./../submodules/chineseInput.nix ];
}
