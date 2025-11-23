{...}: {
  programs.git = {
    enable = true;

    signing = {
      key = "7D9AF1B2C19131AD";
      signByDefault = true;
      # format and signer left unset → HM chooses defaults
    };

    settings = {
      # --- User ---
      user = {
        name = "Zenno Zenith";
        email = "95485961+ZennoZenith@users.noreply.github.com";
        signingKey = "7D9AF1B2C19131AD";
      };

      # --- URL shortcuts ---
      url."git@github.com:".insteadOf = "gh:";
      url."git@github-zennozenith:".insteadOf = "ghz:";
      url."git@github-meeran:".insteadOf = "ghm:";
      url."ssh://git@git.zennozenith.com:2202/zennozenith/".insteadOf = "zz:";

      # --- Core ---
      core = {
        pager = "delta";
        autolf = true;
        autocrlf = "input";
        compression = 9;
        fsync = "none";
        whitespace = "error";
        excludesfile = "~/.gitignore";
      };

      # --- Init ---
      init.defaultBranch = "main";

      # --- Delta ---
      delta = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        true-color = "always";
        dark = true;
        hyperlinks = true;
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };

      # --- Interactive ---
      interactive = {
        diffFilter = "delta --color-only";
        singlekey = true;
      };

      # --- Pager config ---
      pager = {
        branch = false;
        diff = "delta";
        blame = "delta";
      };

      # --- Merge ---
      merge = {
        conflictStyle = "diff3";
      };
      merge."mergiraf" = {
        name = "mergiraf";
        driver = "mergiraf merge --git %O %A %B -s %S -x %X -y %Y -p %P -l %L";
      };

      # --- Diff ---
      diff = {
        context = 3;
        renames = "copies"; # first occurrence
        interHunkContext = 10;
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
      };

      # --- Log ---
      log = {
        abbrevCommit = true;
        graphColors = "blue,yellow,cyan,magenta,green,red";
      };

      # --- Commit ---
      commit = {
        gpgSign = true;
        verbose = true;
      };

      # --- Tag ---
      tag = {
        gpgSign = true;
        sort = "version:refname";
      };

      # --- Push ---
      push = {
        autoSetupRemote = true;
        default = "simple";
        followTags = true;
      };

      # --- Pull ---
      pull.rebase = true;

      # --- Blame ---
      blame = {
        coloring = "highlightRecent";
        date = "relative";
      };

      # --- Status ---
      status = {
        branch = true;
        short = true;
        showStash = true;
        showUntrackedFiles = "all";
      };

      # --- Submodule ---
      submodule.fetchJobs = 16;

      # --- Rebase ---
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      # --- Fetch ---
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      # --- Rerere ---
      rerere = {
        enabled = true;
        autoupdate = true;
      };

      # --- Help ---
      help.autocorrect = "prompt";

      # --- Colors ---
      color.blame.highlightRecent = "black bold,1 year ago,white,1 month ago,default,7 days ago,blue";

      color.branch = {
        current = "magenta";
        local = "default";
        remote = "yellow";
        upstream = "green";
        plain = "blue";
      };

      color.diff = {
        meta = "black bold";
        frag = "magenta";
        context = "white";
        whitespace = "yellow reverse";
      };

      column.ui = "auto";

      branch.sort = "-committerdate";

      # --- Disable advices ---
      advice = {
        addEmptyPathspec = false;
        pushNonFastForward = false;
        statusHints = false;
      };

      # --- Aliases ---
      alias.undo = "reset --sort HEAD^";

      # --- LFS (explicit filter section) ---
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
    };

    # # --- Includes ---
    # includes = [
    #   { path = "~/user.gitconfig"; }

    #   { path = "~/.config/delta/delta.gitconfig"; }

    #   {
    #     condition = "gitdir:~/github/zenith/";
    #     path = "~/zenith.gitconfig";
    #   }

    #   {
    #     condition = "gitdir:~/github/knack/";
    #     path = "~/knack.gitconfig";
    #   }
    # ];

    attributes = [
      "* merge=mergiraf"
      # "*.py merge=mergiraf"
    ];

    ignores = [
      "*.swp"

      # Python specific
      ".mypy_cache/"
      ".pytest_cache/"
      "__pycache__/"
      ".hypothesis/"
      ".ruff_cache/"
      ".ropeproject/"

      # Rust specific
      "target/"

      # Zig specific
      ".zig-cache/"
      "zig-out/"

      # Jujutsu
      ".jj/"
    ];
  };
}
