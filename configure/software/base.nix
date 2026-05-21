{ pkgs, config, lib , ... }:

{
  environment.systemPackages =
    with pkgs; [ 
    vim git git-lfs jq fastfetch tree
    smartmontools
  ] ++ [
    curl wget dig iperf3 nexttrace rclone
  ] ++ [
    # gun
    gnupg gawk gnused gnumake 
    gnutar openssl openssh 
    coreutils moreutils cmake 
    expect qemu findutils
  ] ++ [
    age sops
  ] ++ [
    lima-full
  ];

  environment.variables = {
    EDITOR = "vim";
  };
}

