{pkgs, ...}:{
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
      variant = "nodeadkeys";
    };
  };

  services.keyd = {
    enable = true;
    keyboards = {
      "default" = {
        ids = [ "*" ];
        settings = {
          # This needs to be a Nix attribute set, not a string.
          main = {
            # Bindings with special characters like '+' need to be in quotes.
            "leftcontrol+leftalt" = "rightalt";

            # Other bindings can be added here as well:
            # capslock = "overload(control, escape)";
          };
        };
      };
    };
  };
}
