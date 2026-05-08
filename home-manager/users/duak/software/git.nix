{ pkgs, config, lib, inputs , ... }:
{
  programs.git.enable = true;
 #  programs.git.prompt.enable = true;
  
  programs.git.settings = {
    user.name = "duakc";
    user.email = "young@qeee.net";
    init.defaultBranch = "main";
    include.path = ''${ config.sops.templates."git-sig".path }'';
  };
  
  programs.git.signing = {
    signByDefault = true;
    format = "openpgp";
  };
  sops = {
    secrets."git-sig" = {};
    templates."git-sig".content = ''
        [user]
        signingkey = ${ config.sops.placeholder."git-sig" }
    '';
  };
}
