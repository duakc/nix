{
  description = "Duak's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    
    # Shell rewrite of hraban/mac-app-util — avoids the SBCL fixed-address
    # allocation bug on arm64 macOS 27 (SBCL #2085706).
    mac-app-util.url = "github:XYenon/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-core.flake = false;
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-cask.flake = false;
  
    homebrew-tap-tinypkg.url = "github:tinypkg/homebrew-tap";
    homebrew-tap-tinypkg.flake = false;
  };

  outputs = inputs@{ self,
    nix-darwin, nixpkgs, home-manager, sops-nix, mac-app-util,
    nix-vscode-extensions ,
    # home brews
    nix-homebrew, homebrew-core, homebrew-cask, homebrew-tap-tinypkg, ... }: 
   
    let
      hostName = "duakMac";
      hostPlatform = "aarch64-darwin";
      primaryUser = "duak";
    in 
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#${hostName}
      darwinConfigurations."${hostName}" = nix-darwin.lib.darwinSystem {
        system = "${hostPlatform}";
        modules = [
          sops-nix.darwinModules.sops
          mac-app-util.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
          ./configure
          ./home-manager
          ./brew
        ];
        specialArgs = { inherit inputs hostName hostPlatform primaryUser; };
      };

      packages.aarch64-darwin.default = self.darwinConfigurations."${hostName}".system;
    };
}
