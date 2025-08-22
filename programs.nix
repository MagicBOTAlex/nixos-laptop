{pkgs,...} : {
  environment.systemPackages = with pkgs; [
    neovim
    wget
    iproute2
    curl
    fastfetch
    tree
    btop
    pigz
    ncdu
    screen
    nixfmt-tree
    ffmpeg-full

    firefox
    wl-clipboard
    discord
    killall
    # fontforge

  ];

  programs.starship.enable = true;
}
