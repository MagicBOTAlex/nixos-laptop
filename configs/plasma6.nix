# https://nix-community.github.io/plasma-manager/options.xhtml

{ pkgs, lib, ... }:
let
  toggles = import ./../toggles.nix;
  term = if (toggles.wezterm.enable) then "wezterm" else "konsole";
  ruskWallpaper = pkgs.fetchurl {
    url = "https://deprived.dev/assets/zhen/nixos/RuskBackground-nix.png";
    hash = "sha256-bvwUuWclgAo3aBmG2H65YRUIFgh2xjiHMsICcZQOQf8=";
  };
in {
  programs.plasma = {
    enable = true;
    workspace.colorScheme = "BreezeDark";

    # Shortcuts =====================================
    shortcuts = {
      plasmashell."activate application launcher" = "Meta+S";
      kwin = { "Window Maximize" = "Meta+Up"; };

    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Return";
      command = term;
    };

    hotkeys.commands."launch-konsole2" = {
      name = "Launch Konsole";
      key = "Meta+F1";
      command = term;
    };

    hotkeys.commands."launch-missioncenter" = {
      name = "Launches the windows task manager alternative";
      key = "Ctrl+Shift+Esc";
      command = "missioncenter";
    };

    input.touchpads = [{
      enable = true;
      name = "ELAN06FA:00 04F3:317C Touchpad";
      vendorId = "04f3";
      productId = "317c";
      naturalScroll = true;
    }];

    workspace = {
      wallpaper = ruskWallpaper;
      #
    };

    session.sessionRestore.restoreOpenApplicationsOnLogin =
      "startWithEmptySession";
  };

  # # In toggles.nix if wezterm enabled, then disable konsole
  # environment.plasma6.excludePackages =
  #   lib.optional toggles.wezterm.enable (with pkgs.kdePackages; [ konsole ]);

  programs.konsole = {
    # enable = !toggles.wezterm.enable;
    enable = true;
    defaultProfile = "main";

    profiles."main" = {
      font = {
        name = "CozetteVector-nerd";
        size = 14;
      };

      extraConfig = {
        Keyboard = {
          #
          "Control+Shift+V" = "";
          "Control+V" = "paste";
        };
      };
    };
  };

}
