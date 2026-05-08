{ pkgs , ... }:
{
  imports = [
    ./vscode.nix
    ./ghostty.nix
    ./git.nix
    ./virt-manager.nix
    ./qq.nix
    ./bash.nix
#    ./direnv.nix
  ];
  home.packages = with pkgs; [
    asdf-vm jetbrains-toolbox google-chrome mpv
  ];

}
