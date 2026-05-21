{ pkgs, lib, config, ... }:
let
  cfg = config.programs.asdf-vm;

  inherit (lib)
    mkEnableOption
    mkPackageOption
    mkBefore
    mkIf
    mkOption
    types
    ;
in
{
  options.programs.asdf-vm = {
    enable = mkEnableOption "asdf-vm";
    package = mkPackageOption pkgs "asdf-vm" {
      default = "asdf-vm";
      example = "pkgs.asdf-vm";
    };
    enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };
    enableFishIntegration = lib.hm.shell.mkFishIntegrationOption { inherit config; };
    enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };

    toolVersions = mkOption {
      type = with types; attrsOf str;
      default = {};
      description = ''
        Attribute set of tool versions to set in {file}`~/.tool-versions`.
        Each attribute name is the plugin name, and the value is the version string.
      '';
      example = {
        nodejs = "18.16.0";
        python = "3.11.3";
      };
    };

    plugins = mkOption {
      type = with types; attrsOf str;
      default = {};
      description = ''
        Attribute set of asdf plugins to install. The attribute name is the plugin name,
        and the value is the Git URL of the plugin repository.
      '';
      example = {
        nodejs = "https://github.com/asdf-vm/asdf-nodejs.git";
      };
    };

    autoClean = mkEnableOption ''
      automatically uninstall asdf tool versions that are not specified in
      `programs.asdf-vm.toolVersions`.
      Only plugins that appear in the `toolVersions` attribute set will be checked;
      versions of manually added plugins will not be removed.
    '';
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file.".tool-versions" = mkIf (cfg.toolVersions != {}) {
      text = lib.concatStringsSep "\n"
        (lib.mapAttrsToList (name: version: "${name} ${version}") cfg.toolVersions) + "\n";
    };

    home.activation.installAsdfPlugins = let
      pluginAddCmds = lib.mapAttrsToList (name: url: ''
        if ! ${cfg.package}/bin/asdf plugin list 2>/dev/null | ${pkgs.gnugrep}/bin/grep -Fxq "${name}"; then
          ${cfg.package}/bin/asdf plugin add "${name}" "${url}"
        fi
      '') cfg.plugins;
    in lib.hm.dag.entryAfter ["writeBoundary"] (
      lib.optionalString (cfg.plugins != {}) ''
        export ASDF_DIR="${config.home.homeDirectory}/.asdf"
        export ASDF_DATA_DIR="$ASDF_DIR"
        ${lib.concatStringsSep "\n" pluginAddCmds}
      ''
    );

    home.activation.cleanAsdfVersions = mkIf (cfg.autoClean) (
      let
        cleanCmds = lib.mapAttrsToList (plugin: version: ''
          for ver in $(${cfg.package}/bin/asdf list "${plugin}" 2>/dev/null | ${pkgs.gnused}/bin/sed 's/^[* ]*//;s/ .*//'); do
            if [[ "$ver" != "${version}" ]]; then
              ${cfg.package}/bin/asdf uninstall "${plugin}" "$ver"
            fi
          done
        '') cfg.toolVersions;
      in  
        lib.hm.dag.entryAfter [ "installAsdfPlugins" ] (
          lib.optionalString (cfg.toolVersions != {}) ''
            export ASDF_DIR="${config.home.homeDirectory}/.asdf"
            export ASDF_DATA_DIR="$ASDF_DIR"
            ${lib.concatStringsSep "\n" cleanCmds}
          ''
        )
    );

    programs = {
      bash.initExtra = mkIf cfg.enableBashIntegration (
        mkBefore ''
          export PATH="${config.home.homeDirectory}/.asdf/shims:$PATH"

          source <(${cfg.package}/bin/asdf completion bash)
        ''
      );
      fish.interactiveShellInit = mkIf cfg.enableFishIntegration (
        mkBefore ''
          set -gx PATH "${config.home.homeDirectory}/.asdf/shims" $PATH

          eval (${cfg.package}/bin/asdf completion fish)
        ''
      );
      zsh.initContent = mkIf cfg.enableZshIntegration (
        mkBefore ''
          export PATH="${config.home.homeDirectory}/.asdf/shims:$PATH"

          source <(${cfg.package}/bin/asdf completion zsh)
        ''
      );
    };
  };
}