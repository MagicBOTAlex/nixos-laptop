{pkgs, ...} : {
  programs.fish.enable = true;
  documentation.man.generateCaches = false;

  users.users."botlap".shell = pkgs.fish;
}
