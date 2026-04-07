#!/usr/bin/env bash

# export GIT_PS1_SHOWDIRTYSTATE=true;
export PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")';
export PS1='[\[\e[97m\]\@\[\e[0m\]@\u:\[\e[38;5;117m\]\w\[\e[0m\]]\[\e[92m\]''${PS1_CMD1}\[\e[0m\]> '
