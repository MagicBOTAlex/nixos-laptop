{ pkgs, lib, ... }:
let toggles = import ./../toggles.nix;
in
{
  config = lib.mkIf (toggles.vscode.enable or false) {

    home.packages = with pkgs; [ texliveFull ];
  };
}

