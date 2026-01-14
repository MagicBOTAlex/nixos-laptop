{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ virtiofsd ];

  systemd.system.startVirtiofs = {
    description = "Start virtiofs sock for microvm";

    # Unlimited restarts
    startLimitIntervalSec = 0;
    startLimitBurst = 0;

    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [ virtiofsd ];

    script = "virtiofsd --socket-path=nixos-virtiofs-ro-store.sock --shared-dir=/nix/store --sandbox=none";

    serviceConfig = {
      Restart = "always";
      RestartSec = 1;
    };

  };
}
