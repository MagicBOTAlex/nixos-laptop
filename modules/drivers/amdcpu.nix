{ config, pkgs, lib, ... }:

{
  # AMD CPU setup
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    kernelModules = [ "kvm-amd" "amdgpu" "k10temp" ];
    kernelParams = [ "amd_iommu=on" "iommu=pt" "amd_pstate=active" ];
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  # Graphics
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = { enable = true; };

  # Monitoring tools
  environment.systemPackages = with pkgs; [
    ryzenadj
    zenmonitor
    lm_sensors
    corectrl
  ];

  services.thermald.enable = true;
}
