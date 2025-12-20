{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire."10-sunshine-combo-sink" = {
      "context.objects" = [
        {
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "sunshine-combo";
            "node.description" = "Sunshine Combo Sink (Local + Stream)";
            "media.class" = "Audio/Sink";
            "audio.position" = ["FL" "FR"];
          };
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    pipewire
    pulseaudio
  ];

  ## wpctl status
  services.pipewire.wireplumber.extraConfig."20-clone-audio" = {
    "monitor.stream.rules" = [
      {
        matches = [
          {
            "media.class" = "Stream/Output/Audio";
          }
        ];
        actions = {
          update_props = {
            "node.target" = "33"; # Default to Combo sink (ID 33)
          };
          "link" = [
            {
              "output.port" = "FL";
              "input.port" = "playback_FL";
              "target" = "33"; # Combo sink
            }
            {
              "output.port" = "FR";
              "input.port" = "playback_FR";
              "target" = "33";
            }
            # Clone to USB speakers too (optional, replace 62 with preferred)
            {
              "output.port" = "FL";
              "input.port" = "playback_FL";
              "target" = "62";
            }
            {
              "output.port" = "FR";
              "input.port" = "playback_FR";
              "target" = "62";
            }
          ];
        };
      }
    ];
  };

  # services.pipewire.extraConfig.pipewire."10-sunshine-virtual-sink" = {
  #   "context.objects" = [
  #     {
  #       factory = "adapter";
  #       args = {
  #         "factory.name" = "support.null-audio-sink";
  #         "node.name" = "sunshine-sink";
  #         "node.description" = "Sunshine Virtual Sink";
  #         "media.class" = "Audio/Sink";
  #       };
  #     }
  #   ];
  # };
}
