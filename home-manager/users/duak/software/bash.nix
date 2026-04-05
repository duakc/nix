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
    source ${pkgs.git}/share/bash-completion/completions/git-prompt.sh;

    [[ -f ~/.bash/extra-completion.sh ]] && . ~/.bash/extra-completion.sh;
    [[ -f ~/.bash/env.sh ]] && . ~/.bash/env.sh;
    [[ -f ~/.bash/prompt.sh ]] && . ~/.bash/prompt.sh;
  '';

  home.file.".bash/prompt.sh".text = ''
    #!/usr/bin/env bash
    # export GIT_PS1_SHOWDIRTYSTATE=true;
    export PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")';
    export PS1='[\[\e[97m\]\@\[\e[0m\]@\u:\[\e[38;5;117m\]\w\[\e[0m\]]\[\e[92m\]''${PS1_CMD1}\[\e[0m\]> '
  '';

  home.file.".bash/env.sh".text = ''
    #!/usr/bin/env bash
    export PATH="''${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH";
    export PATH="$PATH:/Users/duak/Library/Application Support/JetBrains/Toolbox/scripts";
  '';

  home.file.".bash/extra-completion.sh".text = ''
    #!/usr/bin/env bash
    source <(asdf completion bash);
  '';
}
