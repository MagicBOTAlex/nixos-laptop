flake-overlays:

{ config, pkgs, lib, inputs, minecraft-plymouth-theme, ... }:
let toggles = import ./toggles.nix;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./aliases.nix
    ./docker.nix
    ./modules/drivers/nvidia.nix
    ./modules/drivers/amdcpu.nix
    ./modules/drivers/bluetooth.nix
    ./modules/lenovoLegion.nix

    #    ./networking/openvpn-work.nix

    ./programs.nix
    ./modules/python.nix
    ./modules/nodejs.nix
    # ./modules/vr.nix
    #    ./modules/steam.nix
    ./modules/spotify.nix
    # ./modules/freecad.nix
    ./modules/gparted.nix

    ./modules/fishShell.nix

    ./users.nix
    ./modules/de.nix

    # ./modules/displayOff.nix

    # Do not disable under here =========================== Disable in toggles.nix
  ] ++ lib.optional (toggles.printing3D.enable or false)
    ./modules/printing3D.nix
  ++ lib.optional (toggles.mineboot.enable or false)
    ./modules/mineboot.nix;
  # ++ lib.optional (!(toggles.mineboot.enable or false))
  #   ./modules/normalBoot.nix;

  nixpkgs.config.permittedInsecurePackages = [ ]
    ++ lib.optional (toggles.printing3D.enable or false) "libsoup-2.74.3";

  nixpkgs.overlays = [
    (final: prev:
      {
        # Your own overlays...
      })
  ] ++ flake-overlays;
  environment.systemPackages = with pkgs; [ ];

  # nix.settings = {
  #   download-attempts = 3;
  #   connect-timeout = 3;
  # };
  environment.variables.EDITOR = "nvim";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # dont worry about it
  nix = {
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) inputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
    settings = {
      nix-path = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
      flake-registry = ""; # optional, ensures flakes are truly self-contained
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
    };
  };

  services.openssh = { enable = true; };
  systemd.services.sshd = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "wpa_supplicant";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users = { "botlap" = import ./home.nix; };
  };

  # Root uses the exact same module
  home-manager.users.root = { pkgs, ... }: {
    home.stateVersion = "24.05";
    imports = [ ./modules/nvim.nix ];
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "BOTAlex";
        email = "zhen@deprived.dev";
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

