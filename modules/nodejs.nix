{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs_22
    serve

    yarn
  ];
}
