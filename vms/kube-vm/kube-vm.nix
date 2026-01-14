{ pkgs, ... }: {
  users.users.root.password = "";
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
    settings.PermitEmptyPasswords = "yes";
  };
  imports = [ ./../../modules/getNvim.nix ];
  environment.systemPackages = with pkgs; [ neovim git wget curl busybox ];

  # --- MicroVM Specific Settings ---
  microvm = {
    # Choose your hypervisor: "qemu", "firecracker", "cloud-hypervisor", etc.
    hypervisor = "qemu";

    # Create a tap interface or user networking
    interfaces = [{
      type = "user"; # 'user' networking is easiest for testing (slirp)
      id = "eth0";
      mac = "02:00:00:00:00:01";
    }];

    # Mount the host's /nix/store explicitly (read-only)
    # This makes the VM start instantly as it shares the host store.
    shares = [{
      source = "/nix/store";
      mountPoint = "/nix/.ro-store";
      tag = "ro-store";
      proto = "virtiofs";
    }];

    # Writable disk allocation
    volumes = [{
      image = "/mnt/cloud/kube-vm/kube-vm.img";
      mountPoint = "/mnt/cloud/kube-vm";
      size = 512; # Size in MB
    }];
  };

  system.stateVersion = "24.11";
}
