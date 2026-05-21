{ pkgs, config, lib, hostPlatform, hostName, primaryUser, inputs, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      inputs.mac-app-util.homeManagerModules.default
      ./modules
    ];
    extraSpecialArgs = { inherit 
      inputs 
      hostPlatform 
      hostName 
      primaryUser
      ; 
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "before-home-manager";

    users = {
      "${primaryUser}" = import ./users/${primaryUser};
    };
  };
}
