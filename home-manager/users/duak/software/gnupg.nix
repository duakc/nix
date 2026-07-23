{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    gnupg pinentry_mac
  ];

  home.file.".gnupg/gpg-agent.conf".text = ''
  pinentry-program /opt/homebrew/bin/pinentry-touchid
  '';
}
