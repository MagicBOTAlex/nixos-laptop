{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ripgrep
    tree-sitter
    clang
    gcc
    godot-mono
    dotnet-sdk_10
    csharpier
  ];


  # Crucial for omnisharp/csharp_ls and global tools to find the SDK
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };

}
