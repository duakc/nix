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
  };

  programs.bash.initExtra = ''
    # https://unix.stackexchange.com/questions/685116/case-insensitive-completion-in-bash
    bind -s 'set completion-ignore-case on'
    source ${pkgs.git}/share/bash-completion/completions/git-prompt.sh;
    
    [[ -f ~/.bash/interactive_functions.sh ]] && . ~/.bash/interactive_functions.sh;
    [[ -f ~/.bash/extra_completion.sh ]] && . ~/.bash/extra_completion.sh;
    [[ -f ~/.bash/env.sh ]] && . ~/.bash/env.sh;
    [[ -f ~/.bash/prompt.sh ]] && . ~/.bash/prompt.sh;
  '';

  home.file.".bash/prompt.sh".text = builtins.readFile ./bash/prompt.sh;
  home.file.".bash/env.sh".text = builtins.readFile ./bash/env.sh;
  home.file.".bash/extra_completion.sh".text = builtins.readFile ./bash/extra_completion.sh;
  home.file.".bash/interactive_functions.sh".text = builtins.readFile ./bash/interactive_functions.sh;
}
