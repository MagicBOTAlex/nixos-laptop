{pkgs, ...} : {
  programs.plasma = {
    enable = true;
    workspace.colorScheme = "BreezeDark";

# Shortcuts =====================================
    shortcuts = {
      plasmashell."activate application launcher" = "Meta+S";
      
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Ctrl+Alt+T";
      command = "konsole";
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

      extraConfig = {
        Keyboard = {
          "Control+V" = "paste";
        };
      };
    };
  };
}
