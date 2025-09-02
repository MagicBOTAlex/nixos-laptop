{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    gparted

    exfat
    exfatprogs
    btrfs-progs
    e2fsprogs
    f2fs-tools
    dosfstools
    hfsprogs
    jfsutils
    mdadm
    util-linux
    nilfs-utils
    ntfsprogs
    udftools
    xfsprogs
  ];
}
