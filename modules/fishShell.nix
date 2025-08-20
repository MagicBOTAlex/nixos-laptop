{pkgs, ...} : {
  programs.fish.enable = true;
  documentation.man.generateCaches = false;

  users.users."botmain".shell = pkgs.fish;
}
