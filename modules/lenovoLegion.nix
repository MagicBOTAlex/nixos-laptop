{ pkgs, config, ... }:
let
  kernel = config.boot.kernelPackages.kernel;

  # The out-of-tree module's custom install target copies only the .ko, not the
  # detached .cer signature that Linux >= 6.18's modules builder concatenates
  # into modules.cer. Sign it with kmodigest after installation so the
  # kernel-modules derivation can find it.
  lenovo-legion-module =
    config.boot.kernelPackages.lenovo-legion-module.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        for module in "$out"/lib/modules/${kernel.modDirVersion}/kernel/drivers/platform/x86/*.ko; do
          ${pkgs.kmodigest}/bin/kmodigest "$module"
        done
      '';
    });
in
{
  boot.extraModulePackages = [ lenovo-legion-module ];
  environment.systemPackages = [ pkgs.lenovo-legion pkgs.dmidecode ];
}
