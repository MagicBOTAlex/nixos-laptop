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
    kubectl

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
    inkscape
    krita
    vtk
    filezilla
    # google-chrome
    wine-wayland

    libreoffice-fresh
    hunspell
    hunspellDicts.da-dk
    # orca-slicer
    sublime-merge
    rustdesk

  ];

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

  programs.starship.enable = true;
}
