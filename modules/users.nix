# modules/users.nix — contas de usuario
{ pkgs, ... }:

{
  users.users."fabricio" = {
    isNormalUser = true;
    description = "Fabricio";
    extraGroups = [
      "networkmanager"
      "wheel"      # sudo
      "docker"     # usar docker sem sudo (necessario p/ distrobox)
    ];
    # Pacotes especificos deste usuario (o grosso fica em systemPackages).
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Firefox habilitado como programa (integra melhor que so o pacote).
  programs.firefox.enable = true;
}
