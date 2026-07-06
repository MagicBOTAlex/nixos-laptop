{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    rip-grep
  ];
}
