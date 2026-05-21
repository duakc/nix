{ pkgs, config, lib, hostPlatform, inputs, ... }:
{

  programs.vscodium.enable = true;
  programs.vscodium.package = pkgs.vscodium;
  programs.vscodium.mutableExtensionsDir = false;
  # may need manually run once command after added a new plugin:
  # `rm -r ~/.vscode/extension && rebuildnix`
  # See: https://github.com/nix-community/home-manager/issues/7880
  programs.vscodium.profiles.default.extensions = with inputs.nix-vscode-extensions.extensions."${hostPlatform}".vscode-marketplace; [
      # vue
      vue.volar 
    ] ++ [ 
      # docs
      unifiedjs.vscode-mdx 
    ] ++ [ 
      # react
      skyran.js-jsx-snippets 
    ] ++ [
      # nix
      bbenoist.nix
    ] ++ [
      # golang
      golang.go
      quillaja.goasm
      liuchao.go-struct-tag
      maracko.json-to-go
    ] ++ [
      # python
      ms-python.python ms-python.debugpy
      ms-python.vscode-python-envs kevinrose.vsc-python-indent
    ] ++ [
      # toolchain
      ms-vscode.makefile-tools docker.docker dbaeumer.vscode-eslint
      ritwickdey.liveserver jock.svg bradlc.vscode-tailwindcss
      
      # # config
      redhat.vscode-yaml tamasfe.even-better-toml
    ] ++ [
      # formatter
      esbenp.prettier-vscode
    ] ++ [ 
      # themes
      be5invis.vscode-icontheme-nomo-dark
    ];

  programs.vscodium.profiles.default = {
    userSettings = {
      "files.autoSave" = "off";
      "update.mode" = "none";
      ## Extension
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      ## Editor
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
      "editor.fontSize" = 17;
      "editor.lineNumbers" = "on";
      "editor.detectIndentation" = false;
      "editor.tabSize" = 2;
      "editor.wordWrap" = "wordWrapColumn";
      ## Workbench
      "workbench.iconTheme" = "vs-nomo-dark";
      # "workbench.colorTheme" = "Visual Studio Dark";
      "workbench.colorTheme" = "Dark+";
      ## Terminal
      "terminal.integrated.defaultProfile.osx" = "bash";
      "terminal.integrated.shellIntegration.enabled" = false;
      "terminal.integrated.enablePersistentSessions" = false;
      "terminal.integrated.inheritEnv" =  false;
      ## YAML
      "yaml.validate" = true;
      "yaml.format.enable" = true;
      ## plguin
      "redhat.telemetry.enabled" = false;
      "json.schemaDownload.trustedDomains" = {
        "https://developer.microsoft.com/json-schemas/" = true;
        "https://github.com" = true;
        "https://json-schema.org/" = true;
        "https://json.schemastore.org/" = true;
        "https://raw.githubusercontent.com/devcontainers/spec/" = true;
        "https://raw.githubusercontent.com/microsoft/vscode/" = true;
        "https://schemastore.azurewebsites.net/" = true;
        "https://www.schemastore.org/" = true;
      };
      "[json]" = {
        "editor.insertSpaces" =  true;
        "editor.tabSize" = 2;
      };
      "[jsonc]" = {
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
      };
      "[yaml]" = {
        "editor.defaultFormatter" = "redhat.vscode-yaml";
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
      };
      "[go]" = {
        "editor.insertSpaces" = false;
        "editor.tabSize" = 4;
      };
      "[javascript]" = {
         "editor.defaultFormatter" = "esbenp.prettier-vscode";
         "editor.insertSpaces" = false;
         "editor.tabSize" = 2;
      };
      "yaml.schemas" = {
        "https://squidfunk.github.io/mkdocs-material/schema.json" = "mkdocs.yml";
      };
      "yaml.customTags" = [ 
        "!ENV scalar"
        "!ENV sequence"
        "!relative scalar"
        "tag:yaml.org,2002:python/name:material.extensions.emoji.to_svg"
        "tag:yaml.org,2002:python/name:material.extensions.emoji.twemoji"
        "tag:yaml.org,2002:python/name:pymdownx.superfences.fence_code_format"
        "tag:yaml.org,2002:python/object/apply:pymdownx.slugs.slugify mapping"
      ];
      "docker.extension.enableComposeLanguageServer" = true;
      "docker.extension.editor.dockerfileBuildStageDecorationLines" = true;
      "docker.lsp.telemetry" = "off";
    };
  };
}
