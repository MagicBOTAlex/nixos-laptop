{ pkgs, ... }: {
  users.users = {
    botlap = {
      isNormalUser = true;
      description = "botlap";
      extraGroups = [
        "projects"
        "networkmanager"
        "wheel"
        "docker"
        "udev"
        "uucp"
        "dialout"
        "clash"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhiPhFbCi64NduuV794omgS8mctBLXtqxbaEJyUo6lg botalex@DESKTOPSKTOP-ENDVV0V"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIFhTExbc9m4dCK6676wGiA8zPjE0l/9Fz2yf0IKvUvg snorre@archlinux"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxUPAsPkri0B+xkO3sCHJZfKgAbgPcepP8J4WW4yyLj u0_a167@localhost"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfQLOKUnOARUAs8X1EL1GRHoCQ0oMun0vzL7Z78yOsM nixos@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJw1ckvXz78ITeqANrWSkJl6PJo2AMA4myNrRMBAB7xW zhentao2004@gmail.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKhcUZbIMX0W27l/FMF5WijpdsJAK329/P008OEAfcyz botmain@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILB0esg3ABIcYWxvQKlPuwEE6cbhNcWjisfky0wnGirJ root@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxUPAsPkri0B+xkO3sCHJZfKgAbgPcepP8J4WW4yyLj u0_a167@localhost"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcy0kVrVojsG5QGAlJoMWVKNAydSz1Uogdc6BcAH8fg vm@ubuntu"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCq0xOfVaABMe9Zg3yQ9InhCcZ4jKJ0yXZK2/qkhr8LdelreCVgHRWw43JFOt+o5zUBj33vm4TRvA9B2auslHV3laB1eF9lntIForQ9HA/wE84gcf4ElOj7xnPbROpchceTAhA8aMscW3km76gIrcHR6RjYe2p90FqdzHdOs47OAgQEg1iiS/VK1yYq6sOYTZHR0BvbCrBgncZP4vA9pmUti7Uvt7SzqsKPfTjdY/hhrUbehVZ+JoiVDB17LK51TCrKbjbvQGIZZ3ZcthMyg/yxxVnhNMNEDJ+AzP2h1Y7Y1uyIliGqNTVy0l9YyHXCQOZsiC19DTuIMb4bl3Y9w41EwDMqRX6Y/fC9ZIr2k4icDyB64aHrBaVr5fZhl3v+H5Py84TqaSlgcV/0uFvnRsu+RrP4JDkPzMSYdverBiQ1szm/W2Ikd20wTMDo3rlwtqyXeOHPrcMIwVqDG79ZRkltuUF0EtxFWSUUrVg+c4VrB2cmxd4Ant1jcsFmc7jECNs= mjid@rpi5-mjid1"
      ];
    };

    # root = {
    #   openssh.authorizedKeys.keys = [
    #     # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKhcUZbIMX0W27l/FMF5WijpdsJAK329/P008OEAfcyz botmain@nixos"
    #   ];
    # };
  };

  security.sudo.extraConfig = ''
    Defaults        timestamp_timeout=300
  '';

  security.sudo.extraRules = [
    {
      users = [ "botlap" ];
      commands = [
        {
          command = "/home/botmain/.nix-profile/bin/ydotool";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
