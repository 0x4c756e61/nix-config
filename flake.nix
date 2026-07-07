{
  description = "Home Manager configuration of lyna";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    moonlight = {
      url = "github:moonlight-mod/moonlight";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixgl,
      nixpkgs,
      home-manager,
      moonlight,
      vicinae,
      zen-browser,
      ...
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
        overlays = [
          nixgl.overlay
        ];
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      homeConfigurations."luna" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./hosts/rover/home.nix ];
        extraSpecialArgs = {
          nixgl = nixgl;
          moonlight = moonlight;
          vicinae = vicinae;
          zen-browser = zen-browser;
        };
      };
    };
}
