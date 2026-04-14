{ pkgs, config, lib , ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [ 
    vim git git-lfs jq fastfetch tree
    smartmontools
  ] ++ [
    curl wget dig iperf3 nexttrace rclone
  ] ++ [
    gnupg gawk gnused gnumake 
    gnutar openssl openssh 
    coreutils moreutils cmake 
    expect
  ] ++ [
    age sops
  ];

  environment.variables = {
    EDITOR = "vim";
  };
}

