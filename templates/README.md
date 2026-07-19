# Templates de ambiente de desenvolvimento

Cada pasta tem um `flake.nix` (define o ambiente) e um `.envrc` (ativa
via direnv). Para iniciar um projeto novo, copie os dois arquivos para
a pasta do projeto.

## Como usar

```bash
# 1. Copie o template escolhido para o seu projeto
cp ~/nixos-setup/templates/python-uv/flake.nix  ~/meu-projeto/
cp ~/nixos-setup/templates/python-uv/.envrc      ~/meu-projeto/

# 2. Entre na pasta e autorize o direnv (so na primeira vez)
cd ~/meu-projeto
direnv allow

# Pronto. A partir de agora, toda vez que voce entrar nessa pasta o
# ambiente carrega sozinho — sem 'nix develop' manual.
```

Sem direnv (manual): `nix develop` dentro da pasta faz a mesma coisa.

## Qual template escolher

| Template          | Quando usar                                                        |
|-------------------|--------------------------------------------------------------------|
| `python-uv`       | Padrao para Python. uv gerencia deps e venv a partir do pyproject. |
| `python-nixpkgs`  | Quando quer libs reproduziveis do nixpkgs + venv so para extras.   |
| `julia`           | Projetos Julia (SepSizing.jl). Pkg cuida das deps via Project.toml.|
| `rust`            | Projetos Rust com toolchain do nixpkgs.                            |
| `c-cpp`           | C/C++ com gcc/cmake/clangd.                                        |

## Observacoes

- Todos usam `nixos-26.05` como base, igual ao sistema. Ao rodar a
  primeira vez, cada projeto gera seu proprio `flake.lock` — commite
  junto com o `flake.nix` para reprodutibilidade.
- `nix-ld` esta ativo no sistema, entao wheels binarias de Python
  (numpy, pyzmq, torch) e toolchains do rustup funcionam sem precisar
  patchar `LD_LIBRARY_PATH` em cada projeto.
- Adicione `.venv/`, `.direnv/` e afins ao `.gitignore` do projeto.
