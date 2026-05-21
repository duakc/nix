{ pkgs, config, lib, ... }:
let
  homeDirectory = config.home.homeDirectory;
  sshHome = ".ssh";
in
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    enableDefaultConfig = false;
    includes = [
      "/etc/ssh/ssh_config.d/*.conf"
      "${homeDirectory}/${sshHome}/config.d/*.conf"
    ];
    matchBlocks = {
      "*" = {
        identityFile = "${homeDirectory}/${sshHome}/";
        sendEnv = [ "TERM" ];
        setEnv = {
          TERM = "xterm-256color";
        };
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        # use 443 to bypass 22 block in some servers
        port = 443;
      };
    };
  };
}