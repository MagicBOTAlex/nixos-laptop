{ pkgs, lib, ... }:
let
  toggles = import ./../toggles.nix;

  # Custom desktop icon
  customLogo = pkgs.fetchurl {
    url = "https://static.wikia.nocookie.net/feed-the-beast/images/0/07/Iso_Computer.png/revision/latest?cb=20130214161136";
    sha256 = "sha256-LLFe13tuWn+TrNeFSMfmKe+9ZUxmxHT/hVcdbyRpBIc=";
  };

  # UUID for the default profile in Ptyxis
  defaultProfileUuid = "21e25790c37b34b172a5ff6b7e01b443";
in
{
  # 1. Install Ptyxis
  home.packages = [ pkgs.ptyxis ];

  # 2. Configure Ptyxis via dconf (font, palette, and behavior)
  dconf.settings = {
    "org/gnome/Ptyxis" = {
      default-profile-uuid = defaultProfileUuid;
      profile-uuids = [ defaultProfileUuid ];
      # Restore window size across sessions
      restore-window-size = true;
    };

    "org/gnome/Ptyxis/Profiles/${defaultProfileUuid}" = {
      label = "Default";
      use-system-font = false;
      font-name = "CozetteVector-nerd 14";
      # Built-in or standard palette selection (catppuccin-mocha is bundled in Ptyxis)
      palette = "catppuccin-mocha";
    };
  };

  # 3. Plasma shortcut binding
  programs.plasma = {
    hotkeys.commands."ptyxis" = {
      name = "Launch Ptyxis";
      key = "Meta+F1";
      command = "ptyxis";
    };
  };

  # 4. Override Desktop Entry with custom ComputerCraft icon
  xdg.desktopEntries."org.gnome.Ptyxis" = {
    name = "Ptyxis";
    comment = "A container-oriented terminal for GNOME";
    icon = customLogo;
    exec = "ptyxis --new-window";
    categories = [
      "System"
      "TerminalEmulator"
    ];
    terminal = false;
    settings = {
      StartupWMClass = "org.gnome.Ptyxis";
    };
  };
}
