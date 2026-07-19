# modules/packages/desktop-apps.nix — aplicativos graficos do dia a dia
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Navegador (o Firefox esta habilitado via programs.firefox em users.nix)
    brave
  ];

  # Removidos do setup anterior (eram sobra de tutorial Hyprland/Sway e
  # nao fazem sentido no Plasma, que ja tem painel/notificacao/gerenciador
  # de arquivos proprios):
  #   waybar   -> Plasma ja tem painel
  #   dunst    -> Plasma ja tem notificacoes
  #   nautilus -> Plasma usa Dolphin (e nautilus puxa meia GNOME junto)
}
