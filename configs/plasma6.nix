# https://nix-community.github.io/plasma-manager/options.xhtml

{ pkgs, lib, ... }:
let
  toggles = import ./../toggles.nix;
  term = if (toggles.wezterm.enable) then "wezterm" else "konsole";
  ruskWallpaper = pkgs.fetchurl {
    url = "https://deprived.dev/assets/zhen/nixos/RuskBackground-nix.png";
    hash = "sha256-bvwUuWclgAo3aBmG2H65YRUIFgh2xjiHMsICcZQOQf8=";
  };
in
{
  programs.plasma = {
    enable = true;
    workspace.colorScheme = "BreezeDark";

    # Shortcuts =====================================
    shortcuts = {
      plasmashell."activate application launcher" = "Meta+S";
      kwin = { "Window Maximize" = "Meta+Up"; };

    };

    hotkeys.commands =
      {
        "launch-konsole" = {
          name = "Launch Konsole";
          key = "Meta+Return";
          command = term;
        };

        "launch-konsole2" = {
          name = "Launch Konsole";
          key = "Meta+F1";
          command = term;
        };

        "launch-missioncenter" = {
          name = "Launches the windows task manager alternative";
          key = "Ctrl+Shift+Esc";
          command = "missioncenter";
        };

        "screenshot-to-clipboard" = {
          name = "Region screenshot to clipboard";
          key = "Meta+Shift+S";
          command = "spectacle -brc";
        };

        "qalculate" = {
          name = "Windows like quick calculate";
          key = "Alt+Space";
          command = "qalculate-qt";
        };
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
    spectacle.shortcuts.launch = "";
  };

  # # In toggles.nix if wezterm enabled, then disable konsole
  # environment.plasma6.excludePackages =
  #   lib.optional toggles.wezterm.enable (with pkgs.kdePackages; [ konsole ]);

  home.packages = with pkgs; [ qalculate-qt ];

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
