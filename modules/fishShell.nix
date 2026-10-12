{pkgs, ...} : {
  programs.fish.enable = true;
  documentation.man.cache.enable = false;

  users.users."botlap".shell = pkgs.fish;
}
