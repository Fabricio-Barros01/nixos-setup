# modules/nix-settings.nix — comportamento do proprio Nix
{ pkgs, ... }:

{
  # Flakes + comando novo 'nix'
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Otimizacao do store (deduplica arquivos identicos por hardlink)
  nix.settings.auto-optimise-store = true;

  # Garbage collection automatico — impede o /nix/store de crescer sem fim.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Pacotes unfree liberados (vscode, etc.)
  nixpkgs.config.allowUnfree = true;

  # -------------------------------------------------------------------
  # nix-ld: faz binarios dinamicos "de fora do Nix" funcionarem.
  # Resolve o classico 'libstdc++.so.6: cannot open shared object file'
  # que aparece com wheels do pip/uv (pyzmq, numpy, torch), toolchains
  # do rustup, etc. Sem isso voce teria que patchar LD_LIBRARY_PATH em
  # cada projeto.
  # -------------------------------------------------------------------
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib   # libstdc++
    zlib
    zstd
    openssl
    curl
    glib
    util-linux
    glibc
    # graficos / libs que wheels cientificas as vezes pedem
    libGL
    libX11
    libXext
    libXrender
    libXi
    fontconfig
    freetype
  ];

  # -------------------------------------------------------------------
  # direnv + nix-direnv: ao entrar numa pasta de projeto com .envrc
  # contendo 'use flake', o ambiente de dev carrega sozinho (sem
  # precisar rodar 'nix develop' na mao). nix-direnv adiciona cache,
  # deixando a entrada quase instantanea depois da primeira vez.
  # -------------------------------------------------------------------
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
