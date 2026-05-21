{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf types genAttrs;
  cfg = config.programs.lima;
  yamlFormat = pkgs.formats.yaml { };

  mkConfigItem = name: {
    option = mkOption {
      type = with types; nullOr (either lines attrs);
      default = null;
      description = "Contents of Lima configuration file for ${name}.yaml (~/.lima/_config/${name}.yaml). Set to null to skip managing it.";
    };
    file =
      let
        opt = cfg.${name};
        base = if builtins.isAttrs opt then {
          source = yamlFormat.generate "${name}.yaml" opt;
        } else {
          text = opt;
        };
      in
        mkIf (opt != null) (base // {
          enable = (opt != null);
        });
  };

  configNames = [ "defaultConfig" "overrideConfig" "networkConfig" ];

  options = genAttrs configNames (name: (mkConfigItem name).option);

  files = genAttrs configNames (name: (mkConfigItem name).file);
in
{
  options.programs.lima = {
    enable = mkEnableOption "lima";
    package = lib.mkPackageOption pkgs "lima" {
      default = "lima";
      example = "pkgs.lima-full";
    };
  } // options;

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.file = {
      ".lima/_config/default.yaml" = files.defaultConfig;
      ".lima/_config/override.yaml" = files.overrideConfig;
      ".lima/_config/network.yaml" = files.networkConfig;
    };
  };
}