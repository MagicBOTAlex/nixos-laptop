{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  toggles = import ./../toggles.nix;

  # Reference the local image directly:
  customLogo = ./../images/Iso_Computer.png;

  # Built from the private ptyxis fork (git input), which remaps
  # Ctrl+Backspace -> Ctrl+W and encodes Shift+Enter like wezterm.
  ptyxisCustom =
    inputs.ptyxis.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs
      (old: {
        postInstall = (old.postInstall or "") + ''
          # 1. Update the .desktop file icon path
          sed -i "s|^Icon=.*|Icon=${customLogo}|" "$out/share/applications/org.gnome.Ptyxis.desktop"

          # 2. Populate standard PNG sizes in hicolor
          for size in 16 24 32 48 64 128 256 512; do
            mkdir -p "$out/share/icons/hicolor/''${size}x''${size}/apps"
            cp -f "${customLogo}" "$out/share/icons/hicolor/''${size}x''${size}/apps/org.gnome.Ptyxis.png"
            cp -f "${customLogo}" "$out/share/icons/hicolor/''${size}x''${size}/apps/ptyxis.png"
          done

          # 3. Overwrite scalable and symbolic SVGs with the custom icon
          cp -f "${customLogo}" "$out/share/icons/hicolor/scalable/apps/org.gnome.Ptyxis.svg"
          cp -f "${customLogo}" "$out/share/icons/hicolor/symbolic/apps/org.gnome.Ptyxis-symbolic.svg"
        '';
      });

  defaultProfileUuid = "21e25790c37b34b172a5ff6b7e01b443";
in
{
  # 1. Install overridden package
  home.packages = [ ptyxisCustom ];

  # 2. Desktop entry override
  xdg.desktopEntries."org.gnome.Ptyxis" = {
    name = "Ptyxis";
    comment = "A container-oriented terminal for GNOME";
    icon = "${customLogo}";
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

  # 3. Ptyxis settings via dconf
  dconf.settings = {
    "org/gnome/Ptyxis" = {
      default-profile-uuid = defaultProfileUuid;
      profile-uuids = [ defaultProfileUuid ];
      restore-window-size = true;
      interface-style = "dark";
      use-system-font = false;
      font-name = "CozetteVector-nerd 14";
    };

    "org/gnome/Ptyxis/Profiles/${defaultProfileUuid}" = {
      label = "Default";
      use-system-font = false;
      font-name = "CozetteVector-nerd 14";
      palette = "Catppuccin Mocha";
    };

    # The real keys are move-next-tab / move-previous-tab; the previous
    # next-tab / previous-tab entries were not schema keys and were ignored.
    "org/gnome/Ptyxis/Shortcuts" = {
      paste-clipboard = "<Primary>v";
      move-next-tab = "<Primary>Tab";
      move-previous-tab = "<Primary><Shift>Tab";
    };
  };

  # 4. Plasma: hotkeys & default terminal registration
  programs.plasma = {
    hotkeys.commands = {
      "launch-terminal-f1" = {
        name = "Launch Ptyxis (F1)";
        key = "Meta+F1";
        command = "ptyxis --new-window";
      };
      "launch-terminal-return" = {
        name = "Launch Ptyxis (Return)";
        key = "Meta+Return";
        command = "ptyxis --new-window";
      };
    };

    configFile = {
      "kdeglobals"."General"."TerminalApplication" = "ptyxis --new-window";
      "kdeglobals"."General"."TerminalService" = "org.gnome.Ptyxis.desktop";
    };
  };
}
