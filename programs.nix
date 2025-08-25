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

    ### Desktop programs
    firefox
    wl-clipboard
    discord
    killall
    # fontforge
    gparted
    prismlauncher
    mission-center

  ];

  programs.starship.enable = true;
}
