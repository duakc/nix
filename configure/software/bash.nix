{ pkgs, config, lib , ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
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

