{ config, inputs, pkgs, ... }:
let
  # The tinypkg tap also ships Casks/snapzy.rb, which collides with the
  # official duongductrong/snapzy tap. `brew bundle` resolves the bare
  # `snapzy` token across *all* tapped taps during its pre-fetch step
  # (it ignores the fully-qualified name there), so the duplicate makes
  # activation fail with "Cask snapzy exists in multiple taps".
  #
  # We only want fcitx5-pinyin from here, so hand nix-homebrew a copy of
  # the tap with snapzy.rb stripped out. This tracks the flake input
  # automatically — no fork to maintain.
  tapInput = pkgs.runCommandLocal "tinypkg-tap-no-snapzy" { } ''
    cp -R ${inputs.homebrew-tap-tinypkg} $out
    chmod -R u+w $out
    rm -f $out/Casks/snapzy.rb
  '';
in
{
  nix-homebrew.taps = {
    "tinypkg/homebrew-tap" = tapInput;
  };
  nix-homebrew.trust = {
    taps = [
      "tinypkg/tap"
    ];
    casks = [
      "tinypkg/tap/fcitx5-pinyin"
    ];
  };

  homebrew.casks = [
    "tinypkg/tap/fcitx5-pinyin"
  ];
}
