{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ virtiofsd ];

  microvm.autostart = [ "kube-vm" ];

}
