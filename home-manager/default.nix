{ pkgs, config, lib, inputs, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      inputs.mac-app-util.homeManagerModules.default
    ];
    useGlobalPkgs = true;
    useUserPackages = true;
    users."duak" = import ./users/duak;
  };
}
