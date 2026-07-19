# nixos-setup

Configuracao do meu NixOS (flakes, sem home-manager).

## Estrutura

```
.
├── flake.nix                  # entrada; define nixosConfigurations.nixos
├── configuration.nix          # indice: importa os modulos
├── hardware-configuration.nix # gerado pelo instalador (nao editar)
├── modules/
│   ├── boot.nix               # bootloader, limite de geracoes
│   ├── network.nix            # NetworkManager, DNS, firewall
│   ├── locale.nix             # fuso, idioma, teclado
│   ├── desktop.nix            # Plasma 6, SDDM, PipeWire, impressao
│   ├── users.nix              # usuario fabricio
│   ├── nix-settings.nix       # flakes, GC, nix-ld, direnv
│   ├── virtualisation.nix     # Docker (backend do distrobox)
│   └── packages/
│       ├── base.nix           # CLI e utilitarios
│       ├── dev.nix            # git, editores, toolchains, pythons
│       ├── engineering.nix    # FreeCAD, ParaView, LibreOffice
│       └── desktop-apps.nix   # Brave
└── templates/                 # flakes de ambiente para copiar em projetos
    ├── README.md
    ├── DISTROBOX.md           # como montar DWSIM e OpenFOAM em container
    ├── python-uv/
    ├── python-nixpkgs/
    ├── julia/
    ├── rust/
    └── c-cpp/
```

## Rebuild

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
# ou, com o nh (mais ergonomico):
nh os switch /etc/nixos
```

## Atualizar pacotes (bump do nixpkgs)

```bash
nix flake update           # atualiza o flake.lock
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

## Decisoes deste setup

- **Sem home-manager**: usuario unico, nao compensa a complexidade agora.
- **OpenFOAM e DWSIM em distrobox** (Ubuntu), nao via nixpkgs — casa com
  as versoes usadas nos papers e evita atrito de empacotamento. Passos em
  `templates/DISTROBOX.md`.
- **ParaView nativo** (melhor desempenho grafico para pos-processamento).
- **Multiplos Pythons** (3.10–3.13) crus no sistema; libs por projeto via
  uv/flake. `python`/`python3` apontam para o 3.13.
- **nix-ld** ativo: wheels binarias do pip/uv e toolchains do rustup
  funcionam sem patch manual de LD_LIBRARY_PATH.
- **direnv + nix-direnv**: ambiente de projeto carrega ao entrar na pasta.
```
