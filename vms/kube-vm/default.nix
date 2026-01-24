{ pkgs, ... }: {
  microvm.autostart = [ "kube-vm" ];
  microvm.vms."kube-vm" = {
    config = ./kube-vm.nix;
  };

}
