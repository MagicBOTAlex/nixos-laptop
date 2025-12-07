# https://nix-community.github.io/plasma-manager/options.xhtml

{ pkgs, lib, ... }:
let
  toggles = import ./../toggles.nix;
in
{
  imports = [ ] ++ lib.optional (toggles.neverSleep.enable or false) ./../homeModules/serverfyLaptop.nix;



  programs.plasma = {
    enable = true;

    input.touchpads = [{
      enable = true;
      name = "ELAN06FA:00 04F3:317C Touchpad";
      vendorId = "04f3";
      productId = "317c";
      naturalScroll = true;
    }];

    kscreenlocker = {
      #         lockOnStartup = false;
      # lockOnResume = false;
      passwordRequired = true;
    };
  };
}
