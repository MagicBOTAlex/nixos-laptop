# Because svelte and nodejs has to be snow flakes, this is nessesarry

{ config, pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc # glibc + libstdc++
      zlib
      openssl
      libgcc
    ];
  };
}

