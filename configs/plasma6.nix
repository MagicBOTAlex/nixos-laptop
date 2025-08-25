{ pkgs, ... }: {
  programs.plasma = {
    enable = true;
    workspace.colorScheme = "BreezeDark";

    # Shortcuts =====================================
    shortcuts = {
      plasmashell."activate application launcher" = "Meta+S";

    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Return";
      command = "konsole";
    };

    hotkeys.commands."launch-konsole2" = {
      name = "Launch Konsole";
      key = "Meta+F1";
      command = "konsole";
    };

    hotkeys.commands."launch-missioncenter" = {
      name = "Launches the windows task manager alternative";
      key = "Ctrl+Shift+Esc";
      command = "missioncenter";
    };
  };

  programs.konsole = {
    enable = true;
    defaultProfile = "main";

    profiles."main" = {
      font = {
        name = "CozetteVector-nerd";
        size = 14;
      };

      extraConfig = { Keyboard = { "Control+V" = "paste"; }; };
    };
  };
}
