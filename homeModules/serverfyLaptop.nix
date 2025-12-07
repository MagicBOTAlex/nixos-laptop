{ pkgs, lib, ... }:

{
  programs.plasma = {
    enable = true;

    # Power settings
    powerdevil = {
      # ── AC power ───────────────────────────────────────────────────────────────
      AC = {
        powerButtonAction = lib.mkForce "turnOffScreen";
        whenLaptopLidClosed = lib.mkForce "turnOffScreen";
        autoSuspend = {
          action = lib.mkForce "nothing";
        };
      };

      # ── On Battery ────────────────────────────────────────────────────────────
      battery = {
        powerButtonAction = "turnOffScreen";
        whenLaptopLidClosed = "turnOffScreen";
        autoSuspend = {
          action = "nothing";
        };
      };

      # ── Low Battery ───────────────────────────────────────────────────────────
      lowBattery = {
        powerButtonAction = "turnOffScreen";
        whenLaptopLidClosed = "turnOffScreen";
        autoSuspend = {
          action = "nothing";
        };
      };
    };
  };
}

