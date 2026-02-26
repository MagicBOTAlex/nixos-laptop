{ config, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    pulse.enable = true;

    extraConfig.pipewire."50-rtp-sender" = {
      "context.modules" = [
        {
          name = "libpipewire-module-rtp-sink";
          args = {
            # NETWORK
            "destination.ip" = "192.168.50.58";
            "destination.port" = 46000;

            # ESSENTIAL: Makes it a Speaker, not a Mic grabber
            "media.class" = "Audio/Sink";

            # NAMES
            "node.name" = "Desktop-UDP-Speakers";
            "node.description" = "Desktop (UDP)";

            # REMOVED: audio.format, audio.rate, audio.channels
            # We let PipeWire auto-negotiate these to match the working defaults.

            # TUNING
            "sess.latency.msec" = 100;
          };
        }
      ];
    };
  };
}
