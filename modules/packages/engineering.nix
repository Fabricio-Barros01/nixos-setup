# modules/packages/engineering.nix — CAD, pos-processamento, escritorio
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CAD
    freecad

    # Pos-processamento / visualizacao CFD.
    # Fica NATIVO no sistema (melhor performance grafica). Voce roda o
    # OpenFOAM no container distrobox e abre os resultados aqui, ou usa
    # o ParaView que vem junto do openfoam2412-default dentro do container.
    paraview

    # Escritorio
    libreoffice-fresh
  ];

  # OpenFOAM: NAO instalado via nixpkgs de proposito.
  # Voce optou por rodar a build oficial ESI (openfoam.com / v2412) dentro
  # de um container Ubuntu via distrobox — assim a versao bate com a dos
  # seus papers e nao depende do empacotamento do nixpkgs (que e a versao
  # .org/Foundation, diferente). Passos em templates/DISTROBOX.md.
  #
  # DWSIM: idem — .NET/Mono, roda no container Ubuntu via distrobox.
}
