# Containers distrobox — DWSIM e OpenFOAM

O sistema usa Docker como backend do distrobox (ver
`modules/virtualisation.nix`). O usuario `fabricio` esta no grupo
`docker`, entao os comandos abaixo rodam sem sudo.

Distrobox integra o container ao host: apps graficos abrem no seu
desktop normalmente e o /home e compartilhado.

---

## OpenFOAM v2412 (build oficial ESI — openfoam.com)

Feito num container Ubuntu 24.04 para casar com a versao usada nos papers.

```bash
# 1. Criar e entrar no container
distrobox create -n openfoam --image ubuntu:24.04
distrobox enter openfoam

# 2. Dentro do container: adicionar o repositorio oficial ESI
curl https://dl.openfoam.com/add-debian-repo.sh | sudo bash

# 3. Atualizar e instalar (o pacote -default ja traz o ParaView junto)
sudo apt-get update
sudo apt-get install -y openfoam2412-default

# 4. Carregar o ambiente OpenFOAM na sessao
openfoam2412
# verificar:
foamVersion
```

Para carregar automaticamente ao entrar, adicione ao `~/.bashrc`
(o home e compartilhado com o host — cuidado para nao interferir no
seu shell do NixOS; prefira um alias):

```bash
alias of2412='source /usr/lib/openfoam/openfoam2412/etc/bashrc'
```

Exportar um binario/comando do container para o menu do host (opcional):

```bash
distrobox-export --bin /usr/bin/openfoam2412
```

---

## DWSIM (.NET/Mono — Ubuntu)

```bash
# 1. Criar e entrar
distrobox create -n dwsim --image ubuntu:24.04
distrobox enter dwsim

# 2. Dentro do container, instalar as dependencias Mono e baixar o DWSIM
#    (veja a versao/link mais recente na pagina oficial de releases do DWSIM;
#     o pacote costuma vir como .tar.gz ou instalador Linux)
sudo apt-get update
sudo apt-get install -y mono-complete libgtk2.0-0 libcanberra-gtk-module

# 3. Extrair o DWSIM e rodar (ajuste o caminho conforme o release)
#    Ex.: mono ~/DWSIM/DWSIM.exe

# 4. (opcional) exportar como app no menu do host:
# distrobox-export --app dwsim
```

> Confirme na pagina oficial do DWSIM o link e o nome do arquivo do
> release atual antes de baixar — muda a cada versao.

---

## Comandos uteis de distrobox

```bash
distrobox list                 # containers existentes
distrobox enter <nome>         # entrar
distrobox stop <nome>          # parar
distrobox rm <nome>            # remover (apaga o container, nao o /home)
```
