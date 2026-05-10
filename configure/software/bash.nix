{ pkgs, config, lib , ... }:

{
  environment.systemPackages =
    with pkgs; [ 
    bash bash-completion
  ];
  programs.bash = {
    enable = true;
    completion.enable = true;
    completion.package = pkgs.bash-completion;
  };
}

