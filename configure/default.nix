{ pkgs, config ,lib, inputs, ... }:
{
  imports = [
    ./fonts

    ./software/base.nix
    ./software/bash.nix
    ./software/direnv.nix
    ./software/zsh.nix
  ];
  
  users.users."duak" = import ./users/duak.nix { inherit pkgs config lib inputs; };
  nix.settings.experimental-features = "nix-command flakes";

  system.configurationRevision = with inputs; self.rev or self.dirtyRev or null;

  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
}
