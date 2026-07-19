# modules/packages/base.nix — utilitarios de terminal e sistema
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Editores minimos / essenciais
    vim
    wget
    curl

    # Utilitarios de terminal modernos
    ripgrep      # grep rapido (rg)
    fd           # find amigavel
    bat          # cat com syntax highlight
    eza          # ls moderno
    fzf          # fuzzy finder
    htop
    btop
    unzip
    p7zip
    tree

    # Arquivos e midia
    mpv

    # Workflow Nix
    nh           # helper de rebuild/GC mais ergonomico
    direnv       # (o hook e ativado em nix-settings.nix)
    nix-direnv

    # Containers
    distrobox

    # Terminal (descomente se quiser usar o Kitty)
    # kitty
  ];
}
