{ ... }:
{
  imports = [
    ./base.nix
    ./zsh.nix
    ./bash.nix
    ./ssh.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];
}
