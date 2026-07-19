{
  description = "Projeto Python (base nixpkgs + venv para extras)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Bibliotecas reproduziveis, vindas do nixpkgs (rapidas, cacheadas).
        # Use este bloco para o que existe e funciona bem no nixpkgs.
        pythonEnv = pkgs.python313.withPackages (ps: with ps; [
          pip
          numpy
          scipy
          pandas
          matplotlib
        ]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pythonEnv
            pkgs.python313Packages.venvShellHook
          ];

          # venvShellHook cria/ativa ./.venv automaticamente.
          venvDir = "./.venv";

          # Extras que quebram no nixpkgs (ex.: jupyter puxa sphinx) ou nao
          # existem la vao para o venv via pip. Com nix-ld ativo no sistema,
          # as wheels binarias ja funcionam sem patch de LD_LIBRARY_PATH.
          postShellHook = ''
            [ -f requirements.txt ] && pip install --quiet -r requirements.txt
            echo "Pronto: $(python --version)"
          '';
        };
      });
}
