{ pkgs, config, lib, ... }:
{

  home.packages = with pkgs; [
    vscode
  ];
  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscode;

  programs.vscode.profiles.default = {
     
    extensions = pkgs.nix4vscode.forVscode [
      # languages
      "bbenoist.nix" "golang.go" "quillaja.goasm"

      # tools
      "ms-vscode.makefile-tools" "liuchao.go-struct-tag"
      "maracko.json-to-go" "esbenp.prettier-vscode"
      # appearance
      "be5invis.vscode-icontheme-nomo-dark"
    ];

    userSettings = {
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "update.mode" = "manual";
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.formatOnSave" = true;
      "editor.fontSize" = 17;
      "editor.lineNumbers" = "relative";
      "editor.detectIndentation" = false;
      "editor.tabSize" = 4;
      "files.autoSave" = "off";
      "editor.wordWrap" = "wordWrapColumn";
      "workbench.iconTheme" = "vs-nomo-dark";
      "terminal.integrated.defaultProfile.osx" = "bash";
      "terminal.integrated.shellIntegration.enabled" = false;
      "terminal.integrated.enablePersistentSessions" = false;
      "terminal.integrated.inheritEnv" =  false;
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
      "[go]" = {
        "editor.insertSpaces" = false;
        "editor.tabSize" = 4;
      };
      "[javascript]" = {
         "editor.defaultFormatter" = "esbenp.prettier-vscode";
         "editor.insertSpaces" = false;
         "editor.tabSize" = 2;
      };
    };
  };
}
