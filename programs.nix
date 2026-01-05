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
    ffmpeg
    kubectl
    kiwix

    ### Desktop programs
    firefox
    wl-clipboard
    killall
    bruno
    argocd
    go
    immich-cli
    # fontforge
    gparted
    prismlauncher
    mission-center
    ungoogled-chromium
    megasync
    inkscape
    # krita
    signal-desktop-bin
    vtk
    filezilla
    # google-chrome
    wine-wayland

    libreoffice-fresh
    hunspell
    hunspellDicts.da-dk
    # orca-slicer
    sublime-merge
    # rustdesk
    drawio
    haruna
    toybox
    gitoxide

  ];

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

  programs.starship.enable = true;
}
