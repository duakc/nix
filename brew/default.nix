{ pkgs, config, lib, inputs,... }:
let
  nix-homebrew-manage = import ./nix-homebrew.nix {
    inherit (inputs) homebrew-core homebrew-cask;
  };
in
{
  inherit (nix-homebrew-manage) nix-homebrew;
  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    enableBashIntegration = true;
    caskArgs = {
      appdir = "/Applications";
      require_sha = true;
    };

    brews = [];
    casks = [
      "ungoogled-chromium"
    ];
  };
  
}
