# modules/security.nix

{ config, pkgs, ... }:

{
  ############################################################
  ## Firewall
  ############################################################

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];

    allowPing = false;
    checkReversePath = "strict";
    logReversePathDrops = true;
  };

  ############################################################
  ## Segurança
  ############################################################

  security = {
    sudo.wheelNeedsPassword = true;

    polkit.enable = true;

    apparmor.enable = true;

    audit.enable = true;
  };

  ############################################################
  ## Hardening do Kernel
  ############################################################

  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "kernel.unprivileged_bpf_disabled" = 1;

    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;

    "net.ipv4.tcp_syncookies" = 1;
  };

  ############################################################
  ## Journald
  ############################################################

  services.journald.extraConfig = ''
    SystemMaxUse=1G
    RuntimeMaxUse=200M
  '';

  ############################################################
  ## Ferramentas de Segurança
  ############################################################

  environment.systemPackages = with pkgs; [
    lynis
    clamav

    nftables
    tcpdump
    wireshark
    nmap

    lsof
    strace

    usbutils
    pciutils
  ];
}
