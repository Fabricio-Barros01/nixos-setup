{ ... }:

{
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];

    allowPing = false;
    logReversePathDrops = true;
    checkReversePath = "strict";
  };

  services.resolved.settings.Resolve = {
    enable = true;
    DNSSEC = "allow-downgrade";
    DNSOverTLS = "opportunistic";
  };

  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PermitRootLogin = "no";
  #     PasswordAuthentication = false;
  #     KbdInteractiveAuthentication = false;
  #     X11Forwarding = false;
  #   };
  # };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}



