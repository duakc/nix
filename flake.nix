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
    
    mac-app-util.url = "github:hraban/mac-app-util";
    
    nix4vscode.url = "github:nix-community/nix4vscode";
    nix4vscode.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, 
    nix-darwin, nixpkgs, home-manager, sops-nix, mac-app-util,
    nix4vscode , ... }:
  let 
    pkgs = import nixpkgs {
      config.allowUnfree = true;
      system = "aarch64-darwin";
      overlays = [
        nix4vscode.overlays.default
      ];
    };
  in 
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#duakMac
    darwinConfigurations."duakMac" = nix-darwin.lib.darwinSystem {
      inherit pkgs;
      system = "aarch64-darwin";
      modules = [
        sops-nix.darwinModules.sops
        mac-app-util.darwinModules.default
        ./configure/default.nix
        ./home-manager/default.nix
      ];
      specialArgs = { inherit inputs; };
    };

    packages.aarch64-darwin.default = self.darwinConfigurations."duakMac".system;
  };
}
