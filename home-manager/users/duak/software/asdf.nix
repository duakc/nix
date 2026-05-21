{ config, pkgs, lib, ... }:
{
  programs.asdf-vm = {
    enable = true;
    package = pkgs.asdf-vm;
    autoClean = false;
    toolVersions = {
      golang = "1.26.2";
      nodejs = "25.8.2";
      golangci-lint = "2.11.4";
      pnpm = "10.33.2";
      python = "3.14.5";
    };
  };
}