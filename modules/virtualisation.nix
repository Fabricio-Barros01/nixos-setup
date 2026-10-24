# modules/virtualisation.nix — Podman (backend do distrobox e servicos)
{ ... }:

{
  virtualisation.podman = {
    enable = true;

    # Cria o comando `docker` apontando para o podman (compatibilidade
    # com scripts/docs que chamam `docker`). So funciona sem o Docker.
    dockerCompat = true;

    # Limpa imagens/containers/volumes nao usados periodicamente.
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # O distrobox usa o Podman como backend preferencial. Roda rootless,
  # sem daemon e sem grupo especial — nao precisa de sudo nem do grupo
  # 'docker'.
  #
  # DWSIM       -> distrobox create -n dwsim    --image ubuntu:24.04
  # OpenFOAM    -> distrobox create -n openfoam --image ubuntu:24.04
  # Code_Aster  -> distrobox create -n aster    --image ubuntu:24.04 --home ~/distrobox/aster
  # (passos de instalacao dentro de cada container em templates/DISTROBOX.md)
}
