{ pkgs , ... }:
{
  imports = [
    ./vscode.nix
    ./ghostty.nix
    ./git.nix
    ./virt-manager.nix
    ./qq.nix
    ./bash.nix
    ./direnv.nix
    ./claude.nix
    ./lima.nix
    ./ssh.nix
    ./asdf.nix
  ];
  home.packages = with pkgs; [
    jetbrains-toolbox mpv
  ];

}
