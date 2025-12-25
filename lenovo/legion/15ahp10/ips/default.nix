{
  lib,
  config,
  ...
}:
{
  imports = [
    ../common.nix
  ];

  # √(2560² + 1600²) px / 15 in ≃ 151 dpi (IPS)
  services.xserver.dpi = 151;
}
