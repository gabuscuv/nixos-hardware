{
  lib,
  config,
  ...
}:
{
  imports = [
    ../common_15ahp10.nix
  ];

  # √(2560² + 1600²) px / 15 in ≃ 201 dpi (OLED)
  services.xserver.dpi = 201;
}
