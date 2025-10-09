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

    forgejo-cli = {
      url = "git+https://codeberg.org/Cyborus/forgejo-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixgl,
      nixpkgs,
      home-manager,
      forgejo-cli,
      ...
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          nixgl.overlay
          (final: prev: {
            libvdpau-va-gl = prev.libvdpau-va-gl.overrideAttrs (
              oldAttrs: {
                cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
                  "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
                ];
              }
            );
          })
        ];
      };
      nixGLWrapped = {
          packages = import nixgl { inherit pkgs; };
        };
    in
    {
      homeConfigurations."luna" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];


        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          nixgl = nixGLWrapped;
          forgejo-cli = forgejo-cli;
        };
      };
    };
}
