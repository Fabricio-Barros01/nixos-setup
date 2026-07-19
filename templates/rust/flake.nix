{
  description = "Projeto Rust";

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
          # Toolchain do proprio nixpkgs (reproduzivel). Se preferir usar o
          # rustup do sistema, remova rustc/cargo daqui e rode 'rustup default
          # stable' uma vez — funciona por causa do nix-ld.
          buildInputs = with pkgs; [
            rustc
            cargo
            rustfmt
            clippy
            rust-analyzer

            # Linker e libs comuns para dependencias com componente nativo
            gcc
            pkg-config
            openssl
          ];

          # Ajuda o rust-analyzer a achar a fonte da stdlib
          RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

          shellHook = ''
            echo "$(rustc --version) | $(cargo --version)"
          '';
        };
      });
}
