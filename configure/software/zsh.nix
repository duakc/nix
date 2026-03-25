{ pkgs, config, lib , ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [ 
    zsh
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}

