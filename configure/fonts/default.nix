{ pkgs, ... }:
{
  # fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    jetbrains-mono noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
