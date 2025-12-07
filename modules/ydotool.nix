{ pkgs, ... }: {
  programs.ydotool.enable = true;
  users.users = {
    botlap = {
      extraGroups = [ "uinput" "ydotool" ];
    };
  };
  security.sudo.extraRules = [
    {
      users = [ "botlap" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/ydotool";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
  environment.variables.YDOTOOL_SOCKET = "/run/ydotoold/socket";
}
