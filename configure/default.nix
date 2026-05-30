{ pkgs, config ,lib, inputs, primaryUser, hostPlatform,... }:
{
  imports = [
    ./fonts
    ./etc
    ./software
    ./networking
  ];

  users.users."${primaryUser}" = import ./users/${primaryUser}.nix { inherit pkgs config lib inputs; };

  system.configurationRevision = with inputs; self.rev or self.dirtyRev or null;
  system.primaryUser = "${primaryUser}";  
  system.stateVersion = 6;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "${hostPlatform}";

  nix.settings = {
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    experimental-features = "nix-command flakes";
  };
}
