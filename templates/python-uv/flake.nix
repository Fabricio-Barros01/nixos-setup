{
  description = "Projeto Python gerenciado por uv";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          # O uv cria e gerencia o .venv sozinho a partir do pyproject.toml
          # ou requirements.txt. O Nix so fornece o interpretador base e o uv.
          # Troque python313 pela versao que o projeto exige.
          buildInputs = [
            pkgs.python313
            pkgs.uv
          ];

          # Com nix-ld ativo no sistema, wheels binarias (numpy, pyzmq, torch)
          # ja acham libstdc++ etc. Se algum dia faltar uma lib, adicione aqui:
          # LD_LIBRARY_PATH tambem funciona, mas o nix-ld cobre o caso comum.

          shellHook = ''
            echo "Python $(python3 --version) + uv $(uv --version)"
            # uv usa o interpretador do PATH (o do Nix acima):
            export UV_PYTHON_PREFERENCE=only-system
            [ -f pyproject.toml ] && echo "-> uv sync   (instala deps)" || \
              echo "-> uv init && uv add <pacote>   (novo projeto)"
          '';
        };
      });
}
