# modules/ai.nix — IA local (Ollama), opcional para o DWSIM Assistant
#
# GPU: GTX 1650 Mobile (Turing, 4 GB) rodando com o driver aberto
# nouveau + NVK (Vulkan do Mesa). Por isso usamos o backend Vulkan,
# que nao exige o driver proprietario da NVIDIA.
#   - Nesta versao do nixpkgs a opcao `acceleration` foi removida;
#     a aceleracao e escolhida pelo pacote (ollama-vulkan / ollama-cuda).
#   - ollama-vulkan ja define OLLAMA_VULKAN=1.
#   - Para CUDA seria preciso hardware.nvidia (driver proprietario +
#     PRIME offload) e package = pkgs.ollama-cuda.
#   - O servico tambem instala o comando `ollama` no sistema.
#
# Escuta em 127.0.0.1:11434; o distrobox compartilha a rede do host,
# entao o DWSIM dentro do container enxerga o mesmo endereco.
{ pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;

    # Modelos baixados automaticamente (servico ollama-model-loader).
    # qwen2.5:3b (~1.9 GB) cabe inteiro nos 4 GB de VRAM;
    # qwen2.5:7b (~4.7 GB) nao cabe e dividiria com a RAM (7.6 GB).
    # loadModels = [ "qwen2.5:3b" ];
  };
}
