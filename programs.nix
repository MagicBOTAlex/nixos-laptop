{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    wget
    iproute2
    curl
    fastfetch
    tree
    pigz
    ncdu
    screen
    nixfmt-tree
    ffmpeg-full
    udev
    systemd

    ### Desktop programs
    firefox
    wl-clipboard
    discord
    killall
    # fontforge
    gparted
    prismlauncher
    mission-center
    ungoogled-chromium
    megasync

    libreoffice-fresh
    hunspell
    hunspellDicts.da-dk
    # orca-slicer
  ];

  programs.starship.enable = true;
}
