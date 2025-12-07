{ pkgs, lib, ... }:
let toggles = import ./toggles.nix;
in
{
  imports = [
    ./modules/nvim.nix
    ./configs/plasma6.nix
    ./configs/sharedPlasma.nix
    ./homeModules/btop.nix

  ] ++ lib.optional (toggles.wezterm.enable or false) ./homeModules/wezterm.nix
  ++ lib.optional (toggles.vscode.enable or false) ./homeModules/vscode.nix;

  # packages only for this user
  home.packages = [ ];

  # env variables for this user
  home.sessionVariables = {
    EDITOR = "nvim"; # use nvim as editor
  };

  home.stateVersion = "25.11";

  # home.file.".local/share/fonts/CozetteVector-nerd.ttf".source =
  #   builtins.fetchurl "https://deprived.dev/assets/CozetteVector-nerd.ttf";

  home.file.".local/share/fonts/CozetteVector-nerd.ttf".source = pkgs.fetchurl {
    url = "https://deprived.dev/assets/CozetteVector-nerd.ttf";
    sha256 = "sha256-ARPAIDFCUOHnlMywNBA6jagEiKxprXK9MtW/z4z1pfU=";
  };

  fonts.fontconfig.enable = true;
}
