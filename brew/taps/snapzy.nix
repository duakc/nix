{ inputs, ... }:
let
  tapInput = inputs.homebrew-tap-duongductrong-snapzy;
in
{
  # Official Snapzy tap (github:duongductrong/Snapzy ships Casks/snapzy.rb).
  # Tap dir on disk is duongductrong/homebrew-snapzy, so brew refers to the
  # cask as duongductrong/snapzy/snapzy.
  nix-homebrew.taps = {
    "duongductrong/homebrew-snapzy" = tapInput;
  };
  nix-homebrew.trust = {
    taps = [ "duongductrong/snapzy" ];
    casks = [ "duongductrong/snapzy/snapzy" ];
  };

  homebrew.casks = [
    "duongductrong/snapzy/snapzy"
  ];
}
