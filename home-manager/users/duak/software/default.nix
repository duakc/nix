{ pkgs , ... }:
{
  imports = [
    ./vscode.nix
    ./ghostty.nix
    ./git.nix
    ./virt-manager.nix
  ];
  home.packages = with pkgs; [
    asdf-vm jetbrains-toolbox google-chrome
  ];

}
