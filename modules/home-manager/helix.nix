{
  pkgs,
  configurationName,
  variables,
  ...
}: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      nixd
      dprint
      ruff
      marksman
      markdown-oxide
      tailwindcss-language-server
    ];
    defaultEditor = true;

    themes = {
      catppuccin_mocha_transparent = {
        inherits = "catppuccin_mocha";
        "ui.background" = {};
      };
      gruvbox_transparent = {
        inherits = "gruvbox";
        "ui.background" = {};
      };
      snazzy_transparent = {
        inherits = "snazzy";
        "ui.background" = {};
      };
      sonokai_transparent = {
        inherits = "sonokai";
        "ui.background" = {};
      };
      tokyonight_transparent = {
        inherits = "tokyonight";
        "ui.background" = {};
      };
    };

    settings = {
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
    };

    languages = {
      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          args = ["--semantic-tokens=true"];
          config.nixd = let
            myFlake = "(builtins.getFlake (toString ${variables.home.homeDirectory}/nixos-dot))";
            nixosOpts = "${myFlake}.nixosConfigurations.${configurationName}.options";
          in {
            nixpkgs.expr = "import ${myFlake}.inputs.nixpkgs { }";
            formatting.command = ["alejandra"];
            options = {
              nixos.expr = nixosOpts;
              home-manager.expr = "${nixosOpts}.home-manager.users.type.getSubOptions []";
            };
          };
        };

        postgrestools = {
          command = "postgrestools";
          args = ["lsp-proxy"];
        };
        biome = {
          command = "biome";
          args = ["lsp-proxy"];
        };
        deno = {
          command = "deno";
          args = ["lsp"];
          config.deno.enable = true;
        };
        emmet-ls = {
          command = "emmet-ls";
          args = ["--stdio"];
        };

        ruff = {
          command = "ruff";
          args = ["server"];
        };

        pyrefly = {
          command = "pyrefly";
          args = ["lsp"];
        };

        tailwindcss-ls = {
          command = "tailwindcss-language-server";
          args = ["--stdio"];
        };

        colors = {
          command = "uwu_colors";
          args = ["--variable-completions"];
          except-features = ["format"];
        };

        rust-analyzer.config = {
          check.command = "clippy";
          cargo.features = "all";
        };

        vscode-json-language-server.config = {
          json = {
            validate = {enable = true;};
            format = {enable = true;};
          };
          provideFormatter = true;
        };

        vscode-css-language-server.config = {
          css = {validate = {enable = true;};};
          scss = {validate = {enable = true;};};
          less = {validate = {enable = true;};};
          providFormatter = true;
        };

        typescript-language-server.config.typescirpt.inlayHints = {
          includeInlayEnumMemberValueHints = false;
          includeInlayFunctionLikeReturnTypeHints = false;
          includeInlayFunctionParameterTypeHints = false;
          includeInlayParameterNameHints = "literals"; #  'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = false;
          includeInlayPropertyDeclarationTypeHints = false;
          includeInlayVariableTypeHints = false;
          includeInlayVariableTypeHintsWhenTypeMatchesName = false;
        };
      };

      language = [
        {
          name = "cpp";
          auto-format = true;
        }
        {
          name = "c";
          auto-format = true;
        }
        {
          name = "toml";
          auto-format = true;
          formatter = {
            command = "dprint";
            args = ["fmt" "--stdin" "toml"];
          };
        }
        {
          name = "python";
          auto-format = true;
          language-servers = ["pyrefly" "ruff"];
        }
        {
          name = "go";
          auto-format = true;
          formatter = {command = "goimports";};
        }
        {
          name = "html";
          auto-format = true;
          language-servers = ["superhtml" "vscode-html-language-server" "tailwindcss-ls" "emmet-ls"];
          formatter = {
            command = "dprint";
            args = ["fmt" "--stdin" "html"];
          };
        }
        {
          name = "css";
          auto-format = true;
          language-servers = ["colors" "vscode-css-language-server" "tailwindcss-ls" "emmet-ls"];
          formatter = {
            command = "dprint";
            args = ["fmt" "--stdin" "css"];
          };
        }
        {
          name = "svelte";
          auto-format = true;
          language-servers = ["svelteserver" "tailwindcss-ls"];
          formatter = {
            command = "dprint";
            args = ["fmt" "--stdin" "svelte"];
          };
        }
        {
          name = "json";
          auto-format = true;
          formatter = {
            command = "dprint";
            args = ["fmt" "--stdin" "json"];
          };
        }
        {
          name = "jsonc";
          auto-format = true;
          formatter = {
            command = "dprint";
            args = ["fmt" "--stdin" "json"];
          };
        }
        {
          name = "markdown";
          auto-format = true;
          formatter = {
            command = "dprint";
            args = ["fmt" "--stdin" "md"];
          };
          language-servers = ["marksman" "markdown-oxide"];
          ## https://github.com/helix-editor/helix/wiki/Recipes#continue-markdown-lists--quotes
          comment-tokens = ["-" "+" "*" "- [ ]" ">"];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
        }
        {
          name = "javascript";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
        }
        {
          name = "jsx";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "tailwindcss-ls"
          ];
        }
        {
          name = "tsx";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "tailwindcss-ls"
          ];
        }
        {
          name = "sql";
          auto-format = true;
          language-servers = ["postgrestools"];
          roots = ["postgrestools.jsonc"];
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nixd" "nil"];
          # language-servers = ["nixd"];
          formatter = {
            command = "alejandra";
          };
        }
        # # is in alpha state https://github.com/nushell/nufmt
        #  [[language]]
        #  name = "nu"
        #  formatter = { command = "nufmt", args = ["--stdin"] }
        #  auto-format = true
      ];
    };
  };
}
