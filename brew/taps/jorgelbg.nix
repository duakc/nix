{ inputs, ... }:
let
  tapInput = inputs.homebrew-tap-jorgelbg;
in
{
  # Official Snapzy tap (github:duongductrong/Snapzy ships Casks/snapzy.rb).
  # Tap dir on disk is duongductrong/homebrew-snapzy, so brew refers to the
  # cask as duongductrong/snapzy/snapzy.
  nix-homebrew.taps = {
    "jorgelbg/homebrew-tap" = tapInput;
  };
  nix-homebrew.trust = {
    taps = [ "jorgelbg/tap" ];
    formulae = [ "jorgelbg/tap/pinentry-touchid" ];
  };

  homebrew.brews = [
    "jorgelbg/tap/pinentry-touchid"
  ];
}
