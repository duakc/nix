{ pkgs, config, lib, inputs, primaryUser,... }:
let
  nix-homebrew-manage = import ./nix-homebrew.nix {
    inherit (inputs) homebrew-core homebrew-cask;
    inherit primaryUser;
  };
  allowUpdate = false;
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
    onActivation = {
      # Set below option to true to update the brews and casks.
      autoUpdate = allowUpdate;
      upgrade = allowUpdate;
      cleanup = "uninstall";
    };

    brews = [
    ];
    casks = [
      "1password"
      "ungoogled-chromium"
    ];
  };
  
}
