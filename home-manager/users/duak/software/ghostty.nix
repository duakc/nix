{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty-bin
  ];
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    installVimSyntax = true;
    enableBashIntegration = true;
    settings = {
      font-family = [ "Jetbrains mono" "Noto Sans Mono" "Source Han Sans SC" ] ;
      font-thicken = false;
      cursor-style = "block";
      mouse-shift-capture = true;
      auto-update = "off";
    };
  };
}
