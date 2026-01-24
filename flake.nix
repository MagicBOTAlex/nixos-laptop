{
  inputs = {
    # get pinned version of nixpkgs. update with `nix flake update nixpkgs` or `nix flake update` for all inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    minemouth.url = "github:nikp123/minecraft-plymouth-theme";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    minesddm = {
      url = "github:Davi-S/sddm-theme-minesddm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, nixpkgs-xr, spicetify-nix, nixpkgs, microvm, minemouth, ... }@inputs:
    let
      flake-overlays = [
        (final: prev: {
          libsForQt5 = (prev.libsForQt5 or { }) // {
            layer-shell-qt = prev.kdePackages.layer-shell-qt;
          };
        })
      ];
    in
    {
      # configuration name matches hostname, so this system is chosen by default
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.config.allowUnfree = true; })
            # import configuration
            (import ./configuration.nix flake-overlays)
            spicetify-nix.nixosModules.default

            inputs.microvm.nixosModules.host
            ./host/microvmSetup.nix

            # home manager part 2
            inputs.home-manager.nixosModules.default

            inputs.minesddm.nixosModules.default
            inputs.minegrub-world-sel-theme.nixosModules.default

            {
              home-manager.sharedModules =
                [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
            }

            inputs.nix-index-database.nixosModules.nix-index

            nixpkgs-xr.nixosModules.nixpkgs-xr

            { programs.nix-index-database.comma.enable = true; }
          ];
        };

        # kube-vm = nixpkgs.lib.nixosSystem {
        #   system = "x86_64-linux";
        #   specialArgs = { inherit inputs; };
        #   modules = [
        #     microvm.nixosModules.microvm
        #     ({ config, pkgs, ... }: { nixpkgs.config.allowUnfree = true; })
        #     ./vms/kube-vm/kube-vm.nix
        #   ];
        # };
      };
    };
}
