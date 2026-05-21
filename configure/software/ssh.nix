{ ... }:
{
  programs.ssh.extraConfig = builtins.readFile ./files/ssh_config ;
}
