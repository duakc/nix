{ config, lib, pkgs, ... }:

let
  inherit (lib) 
    mkEnableOption
    mkOption
    mkAfter
    mkIf
    types
    genAttrs
    ;
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
    limaHome = mkOption {
      type = types.str;
      default = ".lima";
      description = "A relative path from home to Lima Home, See: https://lima-vm.io/docs/dev/internals/ (without ~ and $HOME before)";
    };
    loadSshConfig = mkOption {
      type = types.bool;
      default = false;
      description = "Indicates whether `ssh_config` is managed by Nix to automatically load Lima's `ssh_config`. Requires `programs.ssh.enable == true`";
    };
    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };
    enableFishIntegration = lib.hm.shell.mkFishIntegrationOption { inherit config; };
    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };
    
  } // options;

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.file = {
      "${cfg.limaHome}/_config/default.yaml" = files.defaultConfig;
      "${cfg.limaHome}/_config/override.yaml" = files.overrideConfig;
      "${cfg.limaHome}/_config/network.yaml" = files.networkConfig;
    };

    programs =  {
      ssh.includes = mkIf (cfg.loadSshConfig && config.programs.ssh.enable ) [
        "${config.home.homeDirectory}/${cfg.limaHome}/*/ssh.config"
      ];
      bash.initExtra = mkIf cfg.enableBashIntegration (
        mkAfter ''
          source <(${cfg.package}/bin/limactl completion bash)
        ''
      );

      fish.interactiveShellInit = mkIf cfg.enableFishIntegration (
        mkAfter ''
          eval (${cfg.package}/bin/limactl completion fish)
        ''
      );

      zsh.initContent = mkIf cfg.enableZshIntegration (
        mkAfter ''
        source <(${cfg.package}/bin/limactl completion zsh)
        ''
      );
    };
  };
}