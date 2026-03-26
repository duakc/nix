{ pkgs, config, lib , ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs; [ 
    vim git jq fastfetch gnupg gawk
    iperf3 tree age sops gnumake
    coreutils curl gnutar wget 
  ];
}

