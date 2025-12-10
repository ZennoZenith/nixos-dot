{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "mpd";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable MPD";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.mpd
    ];

    xdg.configFile."${name}/mpd.conf".text = ''
      # https://github.com/Sin-cy/dotfiles/blob/main/mpd/.config/mpd/mpd.conf

      music_directory     "~/Music/mpd/music"
      playlist_directory  "~/Music/mpd/playlists"
      db_file             "~/Music/mpd/db"
      log_file            "~/Music/mpd/mpd.log"
      pid_file            "~/Music/mpd/mpd.pid"
      state_file          "~/Music/mpd/mpdstate"
      auto_update         "yes"
      follow_outside_symlinks "yes"
      follow_inside_symlinks  "yes"

      bind_to_address     "localhost"
      port                "6600"

      # audio_output {
      #         type          "alsa"
      #         name          "ALSA sound card"
      #         # Optional
      #         #device        "iec958:CARD=Intel,DEV=0"
      #         #mixer_control "PCM"
      # }

      audio_output {
              type            "pipewire"
              name            "PipeWire Sound Server"
      }

      audio_output {
          type        "httpd"
          name        "HTTP Stream"
          encoder     "vorbis"
          port        "8000"
          bind_to_address "localhost"
          quality     "5.0"
          format      "44100:16:2"
      }
    '';
  };
}
