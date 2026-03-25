{ pkgs, config, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    direnv nix-direnv
  ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
