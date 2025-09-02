# https://github.com/the-argus/spicetify-nix/blob/master/pkgs/themes.nix

{ lib, config, pkgs, inputs, ... }: {
  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [ adblock fullAppDisplay ];
      enabledCustomApps = with spicePkgs.apps; [ ];
      enabledSnippets = with spicePkgs.snippets; [ ];

      theme = spicePkgs.themes.comfy;
    };
}
