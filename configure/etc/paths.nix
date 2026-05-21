{ config, libs, ... }:
{
  environment.etc."paths.d/90-nix".text = ''
    /run/current-system/sw/bin
  '';
  environment.variables.PATH = "/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:$PATH";
}
