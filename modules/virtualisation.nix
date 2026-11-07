# modules/virtualisation.nix — Podman (distrobox) e Apptainer (Salome-Meca)
{ pkgs, ... }:

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

  # Apptainer (Singularity) — roda imagens .sif, como o Salome-Meca.
  # Monta o $HOME automaticamente, entao ~/Documentos/06.CodeAster
  # fica visivel dentro do Salome no mesmo caminho.
  programs.singularity = {
    enable = true;
    package = pkgs.apptainer;
  };

  # Flatpak: alem de apps Flatpak, fornece o servico D-Bus
  # org.freedesktop.Flatpak (flatpak-session-helper). O `host-spawn` /
  # `distrobox-host-exec` usa esse servico para rodar comandos no host a
  # partir do container (ex.: xdg-open do DWSIM abrindo o Brave). Sem ele,
  # todo host-spawn falha com codigo 127.
  services.flatpak.enable = true;

  # O distrobox usa o Podman como backend preferencial. Roda rootless,
  # sem daemon e sem grupo especial — nao precisa de sudo nem do grupo
  # 'docker'.
  #
  # DWSIM       -> distrobox create -n dwsim    --image ubuntu:24.04
  # OpenFOAM    -> distrobox create -n openfoam --image ubuntu:24.04
  # Code_Aster  -> distrobox create -n aster    --image ubuntu:24.04 --home ~/distrobox/aster
  #                (+ --volume para ~/Documentos/06.CodeAster)
  # Salome-Meca -> apptainer (.sif em ~/Apps/salome-meca), fora do distrobox
  # (passos de instalacao em templates/DISTROBOX.md)
}
