## Based on lenovo legion 16iax10h file and https://www.reddit.com/r/LenovoLegion/comments/1nap74f/my_experience_of_legion_5_2025_on_linux_nixos/
{
  lib,
  config,
  ...
}:
{
  imports = [
    ../../../common/cpu/amd
    ../../../common/gpu/nvidia/prime.nix
    ../../../common/gpu/nvidia/blackwell
    ../../../common/pc/laptop
    ../../../common/pc/ssd
    ../../../common/hidpi.nix
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.lenovo-legion-module ];

  hardware = {
    nvidia = {
      powerManagement.enable = lib.mkDefault true;
      prime = {
        amdgpuBusId = "PCI:64:00:0";
        nvidiaBusId = "PCI:01:00:0";
      };
    };
  };

 ## Reddit Post
   boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];
  
  # Recognize keyboard as internal, so that touchpad is disabled while typing
  environment.etc.
  "libinput/local-overrides.quirks".text = ''
    [Internal Keyboard]
    MatchName=ITE Tech. Inc. ITE Device(8258) Keyboard
    MatchUdevType=keyboard
    AttrKeyboardIntegration=internal
  '';

  # Disable Use Case Manager to make mic work
  services.pipewire.wireplumber.extraConfig.no-ucm = {
    "monitor.alsa.properties" = {
      "alsa.use-ucm" = false;
    };
  };
  
  ## Related to 16iax10h

  # Cooling management
  services.thermald.enable = lib.mkDefault true;

  ## I hope this issue doesn't happen to me.
  ## The original (16iax10h) had ALC3306 and 4 speakers and this has a ALC3287 and two speakers
  ### Sound speaker fix, see #1039
  #  boot.extraModprobeConfig = ''
  # options snd-hda-intel model=auto
  #'';
  #
  # this is an intel thing, But who knows
  #boot.blacklistedKernelModules = [ "snd_soc_avs" ];


}
