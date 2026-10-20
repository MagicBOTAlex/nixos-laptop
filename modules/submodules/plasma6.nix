{ pkgs, lib, ... }:
let
  toggles = import ./../../toggles.nix;
in
{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  }
  // (lib.optionalAttrs (toggles.mineboot.enable or false) {
    theme = "minesddm";
  });

  # baloo is a runtime dep of plasma-workspace/plasma-desktop/dolphin, so
  # excludePackages cannot remove it. Disable the indexer at the config level.
  environment.etc."xdg/baloofilerc".text = ''
    [Basic Settings]
    Indexing-Enabled=false
  '';

  # In toggles.nix if wezterm enabled, then disable konsole
  environment.plasma6.excludePackages = lib.optional (!toggles.wezterm.enable) (
    with pkgs.kdePackages; [ konsole ] baloo baloo-widgets
  );

  services.desktopManager.plasma6.enable = true;

}
