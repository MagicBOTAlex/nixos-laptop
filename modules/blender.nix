{ pkgs, lib, ... }:
let
  customBlender = pkgs.blender.override { cudaSupport = true; };
in
{
  environment.systemPackages = [
    customBlender
    pkgs.cudaPackages.cudnn
    pkgs.cudaPackages.cuda_cccl
  ];
}
