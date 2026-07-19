# modules/desktop.nix — ambiente grafico, audio, impressao
{ ... }:

{
  # Servidor grafico
  services.xserver.enable = true;

  # KDE Plasma 6 + SDDM
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Impressao (CUPS)
  services.printing.enable = true;

  # Audio via PipeWire (substitui PulseAudio)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;   # so se for usar apps JACK
  };
}
