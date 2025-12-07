{ pkgs, lib, ... }:
let toggles = import ./../toggles.nix;
in
{
  config = lib.mkIf (toggles.vscode.enable or false) {
    programs.vscode = {
      enable = true;
      # package = pkgs.vscode-fhs;
      extensions = [ ];
    };

    home.packages = with pkgs; [ texliveFull ];
  };
}

