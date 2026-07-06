{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    wget
    iproute2
    cheese
    pv
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
    tree-sitter
    clang
    gcc
    unzip

    ### Desktop programs
    firefox
    wl-clipboard
    killall
    kicad
    pinta
    arduino-ide
    arduino-cli
    wireguard-tools
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
    signal-desktop
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

    libGL

    vscodium-fhs
    texliveFull
    (pkgs.writeShellScriptBin "code" ''
      exec ${pkgs.vscodium}/bin/codium "$@"
    '')
  ];

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

  programs.starship.enable = true;
}
