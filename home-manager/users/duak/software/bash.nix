{ pkgs, ... }:
{
  home.shell.enableBashIntegration = true;
  home.shell.enableShellIntegration = true;
  
  programs.bash.enable = true;
  programs.bash.shellAliases = {
    ls="ls --color=auto";
    ll="ls -al";
    l="ls";
    grep="grep --color=auto";
    rebuildnix="sudo darwin-rebuild switch --flake ~/.config/nix#duakMac";
    getaddr="dscacheutil -q host -a name";
  };

  programs.bash.initExtra = ''
    # https://unix.stackexchange.com/questions/685116/case-insensitive-completion-in-bash
    bind -s 'set completion-ignore-case on'
    source ${pkgs.git}/share/bash-completion/completions/git-prompt.sh;
    
    [[ -f ~/.bash/env.sh ]] && . ~/.bash/env.sh;
    [[ -f ~/.bash/prompt.sh ]] && . ~/.bash/prompt.sh;
    [[ -f ~/.bash/functions.sh ]] && . ~/.bash/functions.sh;
    [[ -f ~/.bash/completion_.sh ]] && . ~/.bash/completion_.sh;
  '';

  home.file.".bash/env.sh".text = builtins.readFile ./bash/env.sh;
  home.file.".bash/prompt.sh".text = builtins.readFile ./bash/prompt.sh;
  home.file.".bash/functions.sh".text = builtins.readFile ./bash/functions.sh;

  home.file.".bash/completion_.sh".text = builtins.readFile ./bash/completion_.sh;
  home.file.".bash/completion_go.sh".text = builtins.readFile ./bash/completion_go.sh;
}
