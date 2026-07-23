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
    ./aria2c.nix
    ./fcitx5.nix
    ./gnupg.nix
  ];
  home.packages = with pkgs; [
    jetbrains-toolbox mpv moonlight-qt google-chrome
  ];

}
