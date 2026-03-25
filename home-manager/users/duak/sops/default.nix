{ pkgs, config , lib, inputs , ... }:
{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/Library/Application Support/sops/age/keys.txt";
    defaultSopsFile = ./secret.yaml;
    defaultSopsFormat = "yaml";
  };
}
