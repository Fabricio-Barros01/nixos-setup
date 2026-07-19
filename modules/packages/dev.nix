# modules/packages/dev.nix — ferramentas de desenvolvimento
{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # Controle de versao / editores
    git
    vscode

    # Toolchains de build (C/C++, usados por extensoes nativas de Python etc.)
    gcc
    gnumake
    cmake
    pkg-config

    # Rust via rustup (baixa toolchains; funciona gracas ao nix-ld).
    # Depois: rustup default stable
    rustup

    # Julia (SepSizing.jl). julia-bin = binario oficial, evita compilar.
    julia-bin

    # Gerenciador de ambientes/projetos Python (rapido, substitui pip+venv).
    uv

    # Python    
     python313

    # Faz 'python' apontar para 'python3.13' de forma real (symlink no
    # profile do sistema; funciona tambem para scripts, nao so no shell
    # interativo). python3.10..3.13 seguem acessiveis pelos nomes
    # versionados; 'python3' ja e fornecido pelo pacote python313.
    (lib.hiPrio (runCommand "python-default-link" { } ''
      mkdir -p $out/bin
      ln -s ${python313}/bin/python3.13 $out/bin/python
    ''))
  ];
}
