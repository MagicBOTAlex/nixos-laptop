{ pkgs, ... }: {
  # # Enable the XFCE Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;

  imports = [ ./submodules/plasma6.nix ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "botmain";

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.xserver = {
    enable = true;
    libinput.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "dk";
      variant = "";
    };
  };

  services.evremap = {
    enable = true;
    settings = {
      # device_name = "ITE Tech. Inc. ITE Device(8258) Keyboard";
      device_name = "Chicony HP Business Slim Keyboard";
      remap = [
        {
          input = [ "KEY_LEFTALT" "KEY_LEFTCTRL" ];
          output = [ "KEY_RIGHTALT" ];
        }
        {
          input = [ "KEY_LEFTMETA" "KEY_LEFTCTRL" ];
          output = [ "KEY_LEFTALT" "KEY_LEFTCTRL" ];
        }
      ];
    };
  };

  systemd.services.evremap-bluetooth = {
    description = "evremap for external keyboard";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart =
        "${pkgs.evremap}/bin/evremap remap /etc/evremap-bluetooth.toml";
      DynamicUser = true;
      SupplementaryGroups = [ "input" "uinput" ];
      Restart = "on-failure";
    };
  };
  environment.etc."evremap-bluetooth.toml".text = ''
    device_name = "K65 PLUS BLE3 Keyboard"

    [[remap]]
    input = ["KEY_LEFTALT", "KEY_LEFTCTRL"]
    output = ["KEY_RIGHTALT"]

    [[remap]]
    input  = ["KEY_RIGHTCTRL"]
    output = ["KEY_SCROLLLOCK"]
  '';


  # services.keyd = {
  #   enable = true;
  #   keyboards = {
  #     "default" = {
  #       ids = [ "*" ];
  #       settings = {
  #         main = {
  #           "leftcontrol+leftalt" = "rightalt";
  #         };
  #       };
  #     };
  #   };
  # };
}
