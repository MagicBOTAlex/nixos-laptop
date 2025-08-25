{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    motoc # Quest to PC tracking calibration
    wlx-overlay-s # Requires "--fallback" in sudo nixos-rebuild switch --flake /etc/nixos --impure  --fallback
  ];

  services.wivrn = {
    enable = true;
    openFirewall = true;
    autoStart = true;
    # package = pkgs.wivrn.override {
    #   ovrCompatSearchPaths = "${pkgs.xrizer}/lib/xrizer";
    # };

    defaultRuntime = true;
  };
}
