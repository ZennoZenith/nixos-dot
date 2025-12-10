{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "rmpc";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable rmpc";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.rmpc
    ];

    programs.rmpc.enable = true;
    programs.rmpc.config = ''
      // https://github.com/Sin-cy/dotfiles/blob/d94749f986dcf8a29de1313f6f29303995f49a08/rmpc/.config/rmpc/config.ron

      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          address: "localhost:6600",
          password: None,
          enable_config_hot_reload: true,
          theme: "custom",
          volume_step: 5,
          max_fps: 30,
          scrolloff: 0,
          wrap_navigation: false,
          enable_mouse: true,
          status_update_interval_ms: 1000,
          select_current_song_on_change: false,
          album_art: (
              method: Auto,
              max_size_px: (width: 850, height: 850),
              disabled_protocols: ["http://", "https://"],
              vertical_align: Center,
              horizontal_align: Center,
          ),
          keybinds: (
              global: {
                  "u":       Update, // update music database
                  "U":       Rescan,
                  ":":       CommandMode,
                  ".":       VolumeUp,
                  ",":       VolumeDown,
                  "s":       Stop,
                  "<Tab>":   NextTab,
                  "<S-Tab>": PreviousTab,
                  "1":       SwitchToTab("Queue"),
                  "2":       SwitchToTab("Playlists"),
                  "3":       SwitchToTab("Library"),
                  "4":       SwitchToTab("Artists"),
                  "F":       SwitchToTab("Search"),
                  "q":       Quit,
                  ">":       NextTrack,
                  "<":       PreviousTrack,
                  "f":       SeekForward,
                  "b":       SeekBack,
                  "p":       TogglePause,
                  "z":       ToggleRepeat,
                  "x":       ToggleRandom,
                  "c":       ToggleConsume,
                  "v":       ToggleSingle,
                  "?":       ShowHelp,
                  "I":       ShowCurrentSongInfo,
                  "O":       ShowOutputs,
                  "P":       ShowDecoders,
              },
              navigation: { // Playlists pane
                  "k":         Up,
                  "j":         Down,
                  "h":         Left,
                  "l":         Right,
                  "<Up>":      Up,
                  "<Down>":    Down,
                  "<Left>":    Left,
                  "<Right>":   Right,
                  "<C-k>":     PaneUp,
                  "<C-j>":     PaneDown,
                  "<C-h>":     PaneLeft,
                  "<C-l>":     PaneRight,
                  "<C-u>":     UpHalf,
                  "<C-d>":     DownHalf,
                  "N":         PreviousResult,
                  "a":         Add, // add song to queue pane
                  "A":         AddAll,
                  "r":         Rename,
                  "n":         NextResult,
                  "g":         Top,
                  "<Space>":   Select,
                  "<C-Space>": InvertSelection,
                  "G":         Bottom,
                  "<CR>":      Confirm,
                  "i":         FocusInput,
                  "/":         EnterSearch,
                  "<C-c>":     Close,
                  "<Esc>":     Close,
                  "J":         MoveDown, // move song up in playlist
                  "K":         MoveUp, // move song down in playlist
                  "D":         Delete,  // delete a song from playlist
              },
              queue: { // queue pane
                  "D":       DeleteAll,
                  "<CR>":    Play,
                  "a":       AddToPlaylist, // add song to playlist from queue pane
                  "d":       Delete, // delete song from queue
                  "i":       ShowInfo,
                  "C":       JumpToCurrent,
                  "<C-s>":   Save, // save current playng queue to new playlist
              },
          ),
          // Customize Search Tab
          search: (
              case_sensitive: false,
              mode: Contains,
              tags: [
                  (value: "any",         label: "Any Tag"),
                  (value: "title",       label: "Title"),
                  (value: "album",       label: "Album"),
                  (value: "artist",      label: "Artist"),
                  (value: "albumartist", label: "Feat."),
                  (value: "filename",    label: "Filename"),
                  (value: "genre",       label: "Genre"),
              ],
          ),
          artists: (
              album_display_mode: SplitByDate,
              album_sort_by: Date,
          ),
          current_song: (
              format: "{title}\n{artist}\n{album}",
              align: Center,
          ),
          // Customize tabs here
          tabs: [
              (
                  name: "Queue",
                  pane: Split(
                      direction: Horizontal,
                      panes: [
                          (size: "75%", pane: Pane(Queue)),
                          (size: "25%",
                                  pane: Split(
                                      direction: Vertical,
                                      panes: [
                                          (
                                                  size: "75%",
                                                  borders: "NONE",
                                                  pane: Pane(AlbumArt),
                                          ),
                                      ],
                                  ),
                          ),
                      ],
                  ),
              ),
              (
                  name: "Playlists",
                  pane: Split(
                      direction: Horizontal,
                      panes: [(size: "100%", borders: "ALL", pane: Pane(Playlists))],
                  ),
              ),
              (
                  name: "Library",
                  pane: Pane(Directories),
              ),
              (
                  name: "Artists",
                  pane: Split(
                      direction: Horizontal,
                      panes: [(size: "100%", borders: "ALL", pane: Pane(Artists))],
                  ),
              ),
              (
                  name: "Search",
                  pane: Split(
                      direction: Horizontal,
                      panes: [(size: "100%", borders: "ALL", pane: Pane(Search))],
                  ),
              ),
          ],
      )
    '';

    xdg.configFile."${name}/themes/custom.ron".text = ''
      // https://github.com/Sin-cy/dotfiles/blob/main/rmpc/.config/rmpc/themes/custom.ron

      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]

      (
          default_album_art_path: None,
          show_song_table_header: true,
          draw_borders: true,
          browser_column_widths: [20, 30, 60],
          symbols: (song: "󰎈 ",dir: "󰉋 ",marker: " ",ellipsis: "..."),
          text_color: "#e0def4",
          tab_bar: (
              enabled: true,
              active_style: (bg:"#1E1E2E" ,fg: "#FAB387", modifiers: "Bold"),
              inactive_style: (fg: "#908caa", modifiers: ""),
          ),
          highlighted_item_style: (fg: "#A6E3A1", modifiers: "Bold"),
          current_item_style: (fg: "#89B4FA", bg: "#1E1E2E", modifiers: "Bold"),
          borders_style: (fg: "#6e6a86", modifiers: "Bold"),
          highlight_border_style: (fg: "#f6c177"),
          progress_bar: (
              symbols: ["┄", "┅", "━"],
              track_style: (fg: "#26233a"),
              elapsed_style: (fg: "#FAB387"),
              thumb_style: (fg: "#89B4FA"),
          ),
          scrollbar: (
              symbols: ["", "", "", ""],
              track_style: (fg: "#6e6a86"),
              ends_style: (fg: "#6e6a86"),
              thumb_style: (fg: "#f6c177"),
          ),
          browser_song_format: [
              (
                  kind: Group([
                      (kind: Property(Track)),
                      (kind: Text(" ")),
                  ])
              ),
              (
                  kind: Group([
                  (kind: Property(Title)),
                  (kind: Text(" - ")),
                  (kind: Property(Artist)),
                  ]),
                  default: (kind: Property(Filename))
              ),
          ],
          song_table_format: [
              (
                  prop: (kind: Property(Title), style: (fg: "#9ccfd8"),
                      highlighted_item_style: (fg: "#191724", modifiers: "Bold"),
                      default: (kind: Property(Filename), style: (fg: "#6e6a86"),)
                  ),
                  width: "50%",
              ),
              (
                  prop: (kind: Property(Artist), style: (fg: "#ebbcba"),
                      default: (kind: Text("Unknown Artist"), style: (fg: "#908caa"))
                  ),
                  width: "45%",
              ),
              (
                  prop: (kind: Property(Duration), style: (fg: "#f6c177")),
                  width: "10%",
                  alignment: Right,
              ),
          ],
          header: (
              rows: [
                  (
                      left: [
                          (kind: Property(Status(StateV2(playing_label: " 🔊", paused_label: " ❚❚", stopped_label: " ⏹️"))), style: (fg: "#9ccfd8", modifiers: "Bold")),
                      ],
                      center: [
                          (kind: Property(Song(Title)), style: (fg: "#e0def4",modifiers: "Bold"),
                              default: (kind: Property(Song(Filename)), style: (fg: "#e0def4",modifiers: "Bold"))
                          )
                      ],
                      right: [
                          (kind: Text("Vol: "), style: (fg: "#f6c177", modifiers: "Bold")),
                          (kind: Property(Status(Volume)), style: (fg: "#f6c177", modifiers: "Bold")),
                          (kind: Text("% "), style: (fg: "#f6c177", modifiers: "Bold"))
                      ]
                  ),
                  (
                      left: [
                          (kind: Property(Status(Elapsed)),style: (fg: "#e0def4")),
                          (kind: Text("/"),style: (fg: "#6e6a86")),
                          (kind: Property(Status(Duration)),style: (fg: "#e0def4")),
                      ],
                      center: [
                          (kind: Property(Song(Artist)), style: (fg: "#ebbcba", modifiers: "Bold"),
                              default: (kind: Text("Unknown Artist"), style: (fg: "#eb6f92", modifiers: "Bold"))
                          ),
                      ],
                      right: [
                          (
                              kind: Property(Widget(States(
                                  active_style: (fg: "#c4a7e7", modifiers: "Bold"),
                                  separator_style: (fg: "#908caa")))
                              ),
                              style: (fg: "#908caa")
                          ),
                      ]
                  ),
              ],
          ),
          layout: Split(
              direction: Vertical,
              panes: [
                  (
                      size: "4",
                      pane: Split(
                          direction: Horizontal,
                          panes: [
                          (
                                  size: "100%",
                                  pane: Split(
                                      direction: Vertical,
                                      panes: [
                                      (
                                              size: "4",
                                              borders: "ALL",
                                              pane: Pane(Header),
                                          ),
                                      ]
                                  )
                              ),
                          ]
                      ),
                  ),
                  (
                      size: "3",
                      pane: Pane(Tabs),
                  ),
                  (
                      size: "100%",
                      pane: Split(
                          direction: Horizontal,
                          panes: [
                              (
                                  size: "100%",
                                  borders: "NONE",
                                  pane: Pane(TabContent),
                              ),
                          ]
                      ),
                  ),
                  (
                      size: "3",
                      borders: "TOP | BOTTOM",
                      pane: Pane(ProgressBar),
                  ),
              ],
          ),
      )

    '';
  };
}
