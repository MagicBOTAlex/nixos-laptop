# Import in home manager

{ config, lib, pkgs, ... }: {
  # programs.envision = {
  #   enable = true;
  #   openFirewall = true; # This is set true by default
  # };

  environment.systemPackages = with pkgs; [
    motoc # Quest to PC tracking calibration
    wlx-overlay-s # Requires "--fallback" in sudo nixos-rebuild switch --flake /etc/nixos --impure  --fallback
  ];

  # boot.kernelPatches = [{
  #   name = "amdgpu-ignore-ctx-privileges";
  #   patch = pkgs.fetchpatch {
  #     name = "cap_sys_nice_begone.patch";
  #     url =
  #       "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
  #     hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
  #   };
  # }];

  services.wivrn = {
    enable = true;
    openFirewall = true;
    autoStart = true;
    package = pkgs.wivrn.override {
      ovrCompatSearchPaths = "${pkgs.xrizer}/lib/xrizer";
    };

    defaultRuntime = true;
  };
}
