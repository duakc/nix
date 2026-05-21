{ pkg, config, libs, inputs, primaryUser, hostName, hostPlatform, ... }:
{
  networking = {
    hostName = "${hostName}";
    computerName = "${primaryUser}'s ${hostName} on ${hostPlatform}";
    dhcpClientId = "${hostName}-for-${primaryUser}";

    applicationFirewall = {
      enable = false;
    };
    knownNetworkServices = [
      "Wi-Fi" "Thunderbolt Bridge"
    ];
  };
}
