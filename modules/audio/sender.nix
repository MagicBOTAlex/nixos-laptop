{ config, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    pulse.enable = true;

    extraConfig.pipewire."99-network-client" = {
      "context.modules" = [
        {
          name = "libpipewire-module-pulse-tunnel";
          args = {
            # 1. CONNECTION DETAILS
            "tunnel.mode" = "sink"; # We are sending audio (Sink)
            "server.address" = "tcp:192.168.50.58:4713";

            # 2. DEVICE IDENTITY
            # This passes properties directly to the created node
            "stream.props" = {
              "node.name" = "desktop_tunnel";
              "node.description" = "Desktop Speakers";
              "media.class" = "Audio/Sink";

              # 3. LATENCY TUNING
              # "target.delay" controls the buffer size (seconds). 
              # 0.2 = 200ms (Adjust if audio cuts out)
              "target.delay" = 0.2;
            };
          };
        }
      ];
    };
  };
}
