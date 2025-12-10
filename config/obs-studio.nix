{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.variables.LD_LIBRARY_PATH =
    lib.mkDefault "/run/opengl-driver/lib:${"\${LD_LIBRARY_PATH:-"}";

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # environment.systemPackages = [
  #   (pkgs.wrapOBS {
  #     plugins = with pkgs.obs-studio-plugins; [
  #       wlrobs
  #       obs-backgroundremoval
  #       obs-pipewire-audio-capture
  #     ];
  #   })
  # ];

  programs.obs-studio = {
    enable = true;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
