{ pkgs, lib, ... }: {
  imports = [
    ./modules/nvim.nix
    ./configs/plasma6.nix
    # ./homeModules/spotify.nix 
  ];

  # packages only for this user
  home.packages = [ ];

  # env variables for this user
  home.sessionVariables = {
    EDITOR = "nvim"; # use nvim as editor
  };

  home.stateVersion = "25.11";

  home.file.".local/share/fonts/CozetteVector-nerd.ttf".source =
    builtins.fetchurl "https://deprived.dev/assets/CozetteVector-nerd.ttf";

  fonts.fontconfig.enable = true;
}
