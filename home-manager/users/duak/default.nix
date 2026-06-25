{ pkgs, config, lib, ...}:
{
  imports = [
    ./software
    ./sops
  ];

  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.11"; # Please read the comment before changing.
    homeDirectory = "/Users/duak";
    username = "duak";
  };
  programs = {
    home-manager = {
      enable = true;
    };
  };

  manual.manpages.enable = false;
}
