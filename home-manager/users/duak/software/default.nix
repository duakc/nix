{ pkgs , ... }:
{
  imports = [
    ./vscode.nix
    ./qq.nix
    ./ghostty.nix
    ./git.nix
  ];
  home.packages = with pkgs; [
    asdf-vm jetbrains-toolbox
  ];

}
