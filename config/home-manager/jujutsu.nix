{variables, ...}: {
  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = variables.git.name;
        email = variables.git.email;
      };
      git = {
        sign-on-push = true;
        subprocess = true;
      };
      signing = {
        behavior = "own";
        backend = "gpg";
        key = variables.gpg.key;
      };
      ui = {
        default-command = [
          "log"
          "--limit"
          "6"
        ];
        pager = [
          "delta"
          "-s"
          "--dark"
        ];
        diff-formatter = ":git";
        diff-editor = ":builtin";
        merge-editor = "mergiraf";
      };
      colors = {
        "diff removed token" = {
          fg = "bright red";
          bg = "#400000";
          underline = false;
        };
        "diff added token" = {
          fg = "bright green";
          bg = "#003000";
          underline = false;
        };
      };
      aliases = {
        l = [
          "log"
          "-r"
          "ancestors(reachable(@; mutable()); 2)"
        ];
        "n" = [
          "new"
        ];
      };

      merge-tools.meld = {
        merge-conflict-exit-codes = [1];
      };
      merge-tools.mergiraf = {
        merge-conflict-exit-codes = [1];
      };
    };
  };
}
