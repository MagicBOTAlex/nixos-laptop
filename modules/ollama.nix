{ pkgs, lib, ... }: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };
}

