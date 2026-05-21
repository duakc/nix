{ pkgs, config, lib, ...}:
{
  programs.lima = {
    enable = true;
    package = pkgs.lima-full;
    defaultConfig = {
      networks = [
        {
          vzNat = true;
        }
      ];
      portForwards = [
        {
          ignore = true;
          proto = "any";
          guestIP = "0.0.0.0";
        }
      ];
      ssh = {
        loadDotSSHPubKeys = true;
      };
    };
  };
}