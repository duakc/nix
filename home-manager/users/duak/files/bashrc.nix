{ config, ... }:
{
  home.file.".bashrc" = {
    text = ''
     #!/usr/bin/env bash

     [[ $- != *i* ]] && return;

     [[ -f ~/.bash/interactive/default.sh ]] && source ~/.bash/interactive/default.sh;
     
     [[ -f ~/.bash/git-prompt.sh ]] && source ~/.bash/git-prompt.sh
     [[ -f ~/.bash/completion.sh ]] && source ~/.bash/completion.sh;
     [[ -f ~/.bash/env.sh ]] && source ~/.bash/env.sh;

     export PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")';
     export PS1='[\[\e[97m\]\@\[\e[0m\]@\u:\[\e[38;5;117m\]\w\[\e[0m\]]\[\e[92m\]''${PS1_CMD1}\[\e[0m\]> ';
    '';
  };
}
