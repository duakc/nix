{ pkgs, config, lib, inputs , ... }:
{
  programs.git.enable = true;  
  programs.git.settings = {
    # because the macos default filesystem is case insensitive,
    # so`git` should ignore the cases by default.
    # core.ignoreCase = true;
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
