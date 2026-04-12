{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    direnv nix-direnv
  ];
  programs.direnv = {
    enable = true;
    silent = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
