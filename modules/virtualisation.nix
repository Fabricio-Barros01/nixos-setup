# modules/virtualisation.nix — Docker (backend do distrobox e servicos)
{ ... }:

{
  virtualisation.docker = {
    enable = true;

    # Limpa imagens/containers/volumes nao usados periodicamente.
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # O distrobox usa o Docker como backend automaticamente quando o
  # Podman nao esta presente. O usuario 'fabricio' ja esta no grupo
  # 'docker' (ver users.nix), entao roda sem sudo.
  #
  # DWSIM     -> distrobox create -n dwsim   --image ubuntu:24.04
  # OpenFOAM  -> distrobox create -n openfoam --image ubuntu:24.04
  # (passos de instalacao dentro de cada container em templates/DISTROBOX.md)
}
