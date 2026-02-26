{ pkgs, ... }: {
  # environment.systemPackages = with pkgs; [];
  services.hardware.openrgb.enable = true;
}
