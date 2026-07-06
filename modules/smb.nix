{pkgs, ...}: {
      environment.systemPackages = [ pkgs.cifs-utils ];

  environment.etc."smb-shares.creds" = {
    text = ''
      username=smb
      password=smb
    '';
    mode = "0600";
  };

  fileSystems."/mnt/smb-shares" = {
    device = "//10.100.0.18/shares";
    fsType = "cifs";
    options = [
      "credentials=/etc/smb-shares.creds"
      "uid=1000"
      "gid=1000"
      "iocharset=utf8"
      "vers=3.0"
      "x-systemd.automount"
      "noauto"
    ];
  };
  }
