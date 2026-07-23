{ pkgs, config, lib, inputs , ... }:
let
  excludeFile = pkgs.writeText ".${config.home.username}_gitignore_global" ''
    .DS_Store/
    .idea/
    .claude/
    .vscode/
    
    .env
    CLAUDE.md
  '';
in
{
  programs.git.enable = true;  
  programs.git.settings = {
    # because the macos default filesystem is case insensitive,
    # so`git` should ignore the cases by default.
    core.ignoreCase = false;
    user.name = "young";
    user.email = "young@qeee.net";
    init.defaultBranch = "main";
    include.path = ''${ config.sops.templates."git-sig".path }'';
    gpg.openpgp.program = ''${ pkgs.gnupg }/bin/gpg'';
    core.excludesFile = "${excludeFile}";
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
