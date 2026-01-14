# https://nix-community.github.io/plasma-manager/options.xhtml

{ pkgs, inputs, lib, ... }:
let
  toggles = import ./../toggles.nix;
  term = if (toggles.wezterm.enable or false) then "wezterm" else "konsole";
  ruskWallpaper = pkgs.fetchurl {
    url = "https://deprived.dev/assets/zhen/nixos/RuskBackground-nix.png";
    hash = "sha256-bvwUuWclgAo3aBmG2H65YRUIFgh2xjiHMsICcZQOQf8=";
  };
  minecraftWallpaper = pkgs.fetchurl {
    url = "https://deprived.dev/assets/zhen/nixos/MinecraftWallpaper.png";
    hash = "sha256-3ojX5Pfao/D6EgQClXv/6hSvQbaloCW0FsSU9tRA5jM=";
  };
in
{
  imports = [ ./ydotoolShortcuts.nix ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;
    workspace = {
      wallpaper = minecraftWallpaper;
      colorScheme = "BreezeDark";
      theme = "breeze_cursors";
      #
    };

    powerdevil.AC = {
      autoSuspend.action = "nothing";
      powerButtonAction = "shutDown";
    };

    session.sessionRestore.restoreOpenApplicationsOnLogin =
      "startWithEmptySession";

    # Shortcuts =====================================
    hotkeys.commands = {
      "launch-konsole" = {
        name = "Launch terminal emulator";
        key = "Meta+Return";
        command = term;
      };

      "launch-konsole2" = {
        name = "Launch terminal emulator";
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

    spectacle.shortcuts.launch = "";

    window-rules = [
      {
        description = "Keep Qalculate on top";
        match = {
          window-class = {
            value = ".*Qalculate.*";
            type = "regex";
            match-whole = false;
          };
        };
        apply = {
          above = {
            value = true;
            apply = "force";
          };
        };
      }
    ];

    shortcuts = {
      plasmashell."activate application launcher" = "Meta+S";
      plasmashell."kill window" = "Shift+Alt+F4";
      kwin = { "Window Maximize" = "Meta+Up"; };
      "services/systemsettings.desktop"."_launch" = [ ];
    };

    configFile = {
      # Naw, screw the volume change sound notification
      "plasmaparc"."General"."AudioFeedback" = false;
      # Screw this advertizement for firefox extension
      "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
      # Fuck the hot corner thingy that makes overview
      "kwinrc"."Effect-overview"."BorderActivate" = 9;
      "kdeglobals"."General"."fixed" =
        "CozetteVector-nerd,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,nerd";
      "kdeglobals"."General"."TerminalApplication" = "wezterm start --cwd .";
      "kdeglobals"."General"."TerminalService" = "org.wezfurlong.wezterm.desktop";
      "kdeglobals"."Shortcuts"."OpenContextMenu" = "Shift+F10";
      "klaunchrc"."BusyCursorSettings"."Bouncing" = false;
      "klaunchrc"."FeedbackStyle"."BusyCursor" = false;
      "klaunchrc"."FeedbackStyle"."TaskbarButton" = false;
      "kscreenlockerrc"."Daemon"."RequirePassword" = true;
    };
  };

  home.packages = with pkgs; [
    qalculate-qt
    inputs.plasma-manager.packages.${pkgs.system}.rc2nix
    xdg-desktop-portal
    kdePackages.xdg-desktop-portal-kde
  ];

  home.file.".config/kwalletrc".text = ''
    [Wallet]
    Close When Idle=false
    Close on Screensaver=false
    Enabled=false
    First Use=false
    Idle Timeout=10
    Launch Manager=false
    Leave Manager Open=false
    Leave Open=true
    Prompt on Open=false
    Use One Wallet=true

    [org.freedesktop.secrets]
    apiEnabled=true
  '';

  programs = {
    konsole = {
      enable = true;
      defaultProfile = "main";

      profiles."main" = {
        font = {
          name = "CozetteVector-nerd";
          size = 14;
        };

        # extraConfig = { Keyboard = { "Control+V" = "paste"; }; };
      };
    };
  };
}
