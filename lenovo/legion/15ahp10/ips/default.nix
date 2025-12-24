{
  lib,
  config,
  ...
}:
{
  imports = [
    ../common_15ahp10.nix
  ];
  
  # √(1920² + 1200²) px / 15 in ≃ 151 dpi (IPS)
  services.xserver.dpi = 151;
}
