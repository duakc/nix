{ pkgs, ... }:
{
  programs.aria2 = {
    enable = true;
    package = pkgs.aria2;
  };
}
