{ pkgs, ... }: {
  boot.kernelParams = [
    "nowatchdog" # Prevents hardware watchdog timeouts from hanging poweroff
    "acpi_osi=Linux" # Tells firmware to use standard Linux ACPI paths
    "reboot=p,a" # Forces power-off via ACPI/PCI method
  ];
}
