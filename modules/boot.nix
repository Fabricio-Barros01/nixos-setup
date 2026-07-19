# modules/boot.nix — bootloader e kernel
{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Limita quantas geracoes aparecem no menu de boot.
  # Sem isso a particao EFI (/boot) enche com o tempo e o rebuild
  # comeca a falhar por falta de espaco.
  boot.loader.systemd-boot.configurationLimit = 15;

  # Kernel mais recente (opcional). Comente para usar o LTS padrao.
  # boot.kernelPackages = pkgs.linuxPackages_latest;
}
