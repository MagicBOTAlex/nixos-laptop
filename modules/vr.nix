{ config, lib, pkgs, inputs, ... }: {
  environment.systemPackages = with pkgs; [
    motoc # Quest to PC tracking calibration
    wlx-overlay-s # Requires "--fallback" in sudo nixos-rebuild switch --flake /etc/nixos --impure  --fallback
    # wayvr-dashboard
    # (pkgs.callPackage ./submodules/vrcft.nix { })
    oscavmgr
    # inputs.avalonia.packages.x86_64-linux.default

  ];

  services.wivrn = {
    enable = true;
    openFirewall = true;
    # autoStart = true;
    package = pkgs.wivrn.overrideAttrs (oldAttrs: {
      cmakeFlags = oldAttrs.cmakeFlags ++ [
        (lib.cmakeBool "WIVRN_FEATURE_DEBUG_GUI" true)
        (lib.cmakeBool "XRT_FEATURE_OPENXR_LAYER_COLOR_SCALE_BIAS" true)
      ];
      buildInputs = oldAttrs.buildInputs ++ [
        pkgs.sdl2-compat
        pkgs.systemd
        #
      ];
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.makeWrapper ];

      postInstall = (oldAttrs.postInstall or "") + ''
        # Wrap all executables with proper library path
        for binary in $out/bin/*; do
          if [[ -f "$binary" && -x "$binary" ]]; then
            wrapProgram "$binary" \
              --prefix LD_LIBRARY_PATH : "${
                lib.makeLibraryPath [ pkgs.systemd pkgs.udev ]
              }"
          fi
        done
      '';
    });

    defaultRuntime = true;
  };
}
