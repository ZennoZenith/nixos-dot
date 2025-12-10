{
  theme = "tokyonight";
  # theme = "sonokai_transparent";
  # theme = "tokyonight_transparent";
  # theme = "sonokai";
  # theme = "snazzy_transparent";
  # theme = "gruvbox_transparent";
  # theme = "catppuccin_mocha_transparent";
  # theme = "doom_acario_dark" # does not look good for content inside markdown code block;

  editor = {
    bufferline = "multiple";
    color-modes = true;
    completion-trigger-len = 1;
    cursorline = true;
    default-line-ending = "lf";
    insert-final-newline = false;
    idle-timeout = 10;
    line-number = "relative";
    mouse = false;
    rulers = [80];
    scroll-lines = 1;
    true-color = true;
    text-width = 120;
    end-of-line-diagnostics = "hint";
    shell = ["nu" "--stdin" "-c"];

    lsp = {
      display-color-swatches = true;
    };

    statusline = {
      left = [
        "mode"
        "spacer"
        "version-control"
        "spacer"
        "separator"
        "file-name"
        "file-modification-indicator"
      ];
      right = [
        "spinner"
        "spacer"
        "workspace-diagnostics"
        "separator"
        "spacer"
        "diagnostics"
        "selections"
        "position"
        "file-encoding"
        "file-line-ending"
        "file-type"
      ];
      separator = "╎";
    };

    cursor-shape = {
      insert = "bar";
      normal = "block";
      select = "underline";
    };

    file-picker = {
      hidden = false;
    };

    soft-wrap = {
      enable = true;
      max-wrap = 10; # increase value to reduce forced mid-word wrapping
      wrap-at-text-width = true;
    };

    whitespace = {
      render = {
        space = "none";
        nbsp = "all";
        nnbsp = "all";
        tab = "all";
        newline = "none";
      };
      characters = {
        space = "·";
        nbsp = "⍽";
        tab = "→";
        newline = "⏎";
        tabpad = "·"; # Tabs will look like "→···" (depending on tab width)
      };

      indent-guides = {
        render = true;
        character = "╎"; # Some characters that work well: "▏", "┆", "┊", "╎"
        skip-levels = 1;
      };

      inline-diagnostics = {
        cursor-line = "warning"; # show warnings and errors on the cursorline inline
      };
    };
  };

  keys = {
    normal = {
      "K" = "insert_newline";
      C-z = "no_op";
      C-r = "insert_register";
      ret = [
        "move_line_down"
        "goto_first_nonwhitespace"
      ]; # Mps the enter key to move to start of next line
      D = "delete_char_backward";
      C-p = ["move_line_up" "scroll_up"];
      C-n = ["move_line_down" "scroll_down"];
      # esc = ["collapse_selection","keep_primary_selection"]
      esc = ["collapse_selection"];
      ";" = "keep_primary_selection";
      X = "extend_line_up";
      A-x = "extend_line_above";

      # ---------------
      # C-v = "vsplit"
      C-h = "jump_view_left";
      C-j = "jump_view_down";
      C-k = "jump_view_up";
      C-l = "jump_view_right";

      ## DEPRECATED: use `gn` and `gp` instead
      # "C-," = "goto_previous_buffer"
      # "C-." = "goto_next_buffer"

      ## DEPRECATED: collision with zellij change pane focus
      # Move line up/down using A-k, A-j
      # "A-k" = [
      #   "extend_to_line_bounds",
      #   "delete_selection",
      #   "move_line_up",
      #   "paste_before",
      # ]
      # "A-j" = [
      #   "extend_to_line_bounds",
      #   "delete_selection",
      #   "move_line_down",
      #   "paste_before",
      # ]

      space = {
        ## https://github.com/helix-editor/helix/wiki/Recipes#advanced-file-explorer-with-yazi
        # e = [
        #   ":sh rm -f /tmp/unique-file-h21a434",
        #   ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-file-h21a434",
        #   ":insert-output echo \"x1b[?1049h\" | save -a /dev/tty",
        #   ":open %sh{cat /tmp/unique-file-h21a434}",
        #   ":redraw",
        # ]

        f = "file_picker_in_current_directory";
        F = "file_picker";
        w = ":write-all";
        c = ":buffer-close";
        l = [
          ":lsp-stop"
          ":lsp-restart"
        ];

        ## DEPRECATED: use <space>a
        # [keys.normal.g]
        # a = "code_action" # Maps `ga` to show possible code actions
      };
    };

    select = {
      ";" = ["keep_primary_selection" "exit_select_mode"];
    };

    insert = {
      C-z = "no_op";
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
      pageup = "no_op";
      pagedown = "no_op";
      home = "no_op";
      end = "no_op";
      # VSCode-like auto-completeion (pretty much all IDEs do it on C-space)
      "C-space" = "completion";

      ## DEPRECATED: map caps lock to escape and use that
      # j = { k = "normal_mode" } # Maps `jk` to exit insert mode
      #
      ## DEPRECATED: got better at using helix
      # C-ret = "open_below"
      # C-S-ret = "open_above"

      # https://github.com/ravsii/.helix/blob/main/config.toml
    };
  };
}
