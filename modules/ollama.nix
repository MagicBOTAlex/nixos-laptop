{ pkgs, ... }:
let
  ollama-bin = pkgs.stdenv.mkDerivation rec {
    pname = "ollama";
    version = "0.5.7";

    src = pkgs.fetchurl {
      url = "https://ollama.com/download/ollama-linux-amd64.tar.zst";
      hash = "sha256-99a9vPcbg6qGcMTn3EtpNsCVL8+LEU6vahHLrbloQhQ="; # Replace with your actual hash
    };

    nativeBuildInputs = [
      pkgs.zstd
      pkgs.autoPatchelfHook
      pkgs.makeWrapper # Needed to wrap the binary for GPU drivers
    ];

    buildInputs = [
      pkgs.stdenv.cc.cc.lib
      pkgs.glibc
      pkgs.vulkan-loader
    ];

    # Properly instructs autoPatchelfHook to ignore missing driver libraries
    autoPatchelfIgnoreMissingDeps = true;

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/lib

      cp -r bin/* $out/bin/ 2>/dev/null || cp ollama $out/bin/ 2>/dev/null || true
      cp -r lib/* $out/lib/ 2>/dev/null || true

      # Expose NixOS hardware drivers (CUDA/Vulkan) to the binary at runtime
      wrapProgram $out/bin/ollama \
        --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"
        
      runHook postInstall
    '';
  };
in
{
  services.ollama = {
    enable = true;
    package = ollama-bin;
  };
}
