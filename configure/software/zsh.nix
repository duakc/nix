{ pkgs, config, lib , ... }:

{
  environment.systemPackages =
    with pkgs; [ 
    zsh
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}

