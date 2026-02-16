{...}: {
  # programs.firefox.preferences = let
  #   ffVersion = config.programs.firefox.package.version;
  # in {
  #   "media.ffmpeg.vaapi.enabled" = lib.versionOlder ffVersion "137.0.0";
  #   "media.hardware-video-decoding.force-enabled" = lib.versionAtLeast ffVersion "137.0.0";
  #   "media.rdd-ffmpeg.enabled" = lib.versionOlder ffVersion "97.0.0";

  #   "gfx.x11-egl.force-enabled" = true;
  #   "widget.dmabuf.force-enabled" = true;

  #   # Set this to true if your GPU supports AV1.
  #   #
  #   # This can be determined by reading the output of the
  #   # `vainfo` command, after the driver is enabled with
  #   # the environment variable.
  #   "media.av1.enabled" = false;
  # };

  programs = {
    ssh = {
      startAgent = true;
      enableAskPassword = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
      lfs.enablePureSSHTransfer = true;
    };
    dconf.enable = true;

    ## Gui for OpenPGP
    seahorse.enable = true;
    localsend.enable = true;
    localsend.openFirewall = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    foot = {
      enable = true;
      xdg.serverAutostart = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    nix-ld.enable = true;
    nix-ld.libraries = [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];
  };
}
