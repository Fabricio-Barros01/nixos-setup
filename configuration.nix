# configuration.nix
#
# Este arquivo agora e apenas um "indice": ele importa os modulos
# em ./modules/. Para desativar uma area inteira do sistema, basta
# comentar a linha correspondente no imports abaixo e rodar rebuild.
#
# Rebuild:  sudo nixos-rebuild switch --flake /etc/nixos#nixos
#     (ou)  nh os switch /etc/nixos        # se usar o nh

{ ... }:

{
  imports = [
    # Hardware (gerado pelo instalador — nao editar)
    ./hardware-configuration.nix

    # Modulos do sistema
    ./modules/boot.nix
    ./modules/network.nix
    ./modules/locale.nix
    ./modules/desktop.nix
    ./modules/users.nix
    ./modules/nix-settings.nix
    ./modules/virtualisation.nix

    # Conjuntos de pacotes
    ./modules/packages/base.nix
    ./modules/packages/dev.nix
    ./modules/packages/engineering.nix
    ./modules/packages/desktop-apps.nix
  ];

  # NAO alterar depois da primeira instalacao.
  system.stateVersion = "26.05";
}
