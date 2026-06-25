{ pkgs, lib, config, ... }:
let
  fcitx5PinyinCask = "tinypkg/homebrew-tap/fcitx5-pinyin";
in
{
  # https://github.com/tinypkg/homebrew-tap/issues/3
  homebrew = { 
    casks = [
      fcitx5PinyinCask
    ];
  };
  nix-homebrew.trust.casks = [ fcitx5PinyinCask ];
  
  # manage it at home-manager
  #environment.systemPackages = with pkgs; [
  #  fcitx5-pinyin-zhwiki fcitx5-pinyin-moegirl fcitx5-pinyin-minecraft
  #];

} 
