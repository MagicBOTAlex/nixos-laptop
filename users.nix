{ pkgs, ... }: {
  users.users = {
    botlap = {
      isNormalUser = true;
      description = "botlap";
      extraGroups = [ "networkmanager" "wheel" "docker" "udev" ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhiPhFbCi64NduuV794omgS8mctBLXtqxbaEJyUo6lg botalex@DESKTOPSKTOP-ENDVV0V"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIFhTExbc9m4dCK6676wGiA8zPjE0l/9Fz2yf0IKvUvg snorre@archlinux"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxUPAsPkri0B+xkO3sCHJZfKgAbgPcepP8J4WW4yyLj u0_a167@localhost"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfQLOKUnOARUAs8X1EL1GRHoCQ0oMun0vzL7Z78yOsM nixos@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJw1ckvXz78ITeqANrWSkJl6PJo2AMA4myNrRMBAB7xW zhentao2004@gmail.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKhcUZbIMX0W27l/FMF5WijpdsJAK329/P008OEAfcyz botmain@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILB0esg3ABIcYWxvQKlPuwEE6cbhNcWjisfky0wnGirJ root@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxUPAsPkri0B+xkO3sCHJZfKgAbgPcepP8J4WW4yyLj u0_a167@localhost"
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
