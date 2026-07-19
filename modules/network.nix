# modules/network.nix — rede, DNS, firewall
{ ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

  # Firewall ligado por padrao. Abra portas conforme precisar,
  # por exemplo para servicos em Docker (Grafana 3000, Odoo 8069):
  # networking.firewall.allowedTCPPorts = [ 3000 8069 ];
  networking.firewall.enable = true;

  # Servidor SSH — descomente se quiser acesso remoto a esta maquina.
  # services.openssh = {
  #   enable = true;
  #   settings.PasswordAuthentication = false;  # so chave publica
  # };
}
