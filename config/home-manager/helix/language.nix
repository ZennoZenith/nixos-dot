{
  pkgs,
  variables,
}: {
  language-server = {
    nixd = {
      command = "${pkgs.nixd}/bin/nixd";
      args = ["--semantic-tokens=true"];
      config.nixd = let
        myFlake = "(builtins.getFlake (toString ${variables.home.homeDirectory}/nixos-dot))";
        nixosOpts = "${myFlake}.nixosConfigurations.${variables.configurationName}.options";
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
}
