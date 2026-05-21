{ pkgs, config ,lib, inputs, primaryUser, hostPlatform,... }:
{
  imports = [
    ./fonts
    ./etc
    ./software
    ./networking
  ];

  system.configurationRevision = with inputs; self.rev or self.dirtyRev or null;
  system.primaryUser = "${primaryUser}";  
  system.stateVersion = 6;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "${hostPlatform}";

  nix.settings.experimental-features = "nix-command flakes";
  users.users."${primaryUser}" = import ./users/${primaryUser}.nix { inherit pkgs config lib inputs; };
}
