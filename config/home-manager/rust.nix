{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "rust";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable rust";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    programs.cargo.enable = true;
    programs.cargo.settings = {
      # .cargo/config.toml
      # On Windows
      # cargo install -f cargo-binutils
      # rustup component add llvm-tools-preview

      target.x86_64-pc-windows-msvc = {
        rustflags = ["-C" "link-arg=-fuse-ld=lld"];
      };
      target.x86_64-pc-windows-gnu = {
        rustflags = ["-C" "link-arg=-fuse-ld=lld"];
      };

      # On Linux:
      # - Ubuntu, `sudo apt-get install lld clang`
      # - Fedora, `sudo dnf install lld clang`
      # - Arch, `sudo pacman -S lld clang`
      # [target.x86_64-unknown-linux-gnu]
      # rustflags = ["-C", "linker=clang", "-C", "link-arg=-fuse-ld=lld"]

      # - Fedora: sudo dnf install mold clang
      target.x86_64-unknown-linux-gnu = {
        linker = "clang";
        rustflags = ["-C" "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"];
      };

      # # On MacOS, `brew install michaeleisel/zld/zld`
      # target.x86_64-apple-darwin = {
      #   rustflags = ["-C" "link-arg=-fuse-ld=${pkgs.zld}/bin/zld"];
      # };
      # target.aarch64-apple-darwin = {
      #   rustflags = ["-C" "link-arg=-fuse-ld=${pkgs.zld}bin/zld"];
      # };

      build = {
        rustc-wrapper = "${pkgs.sccache}/bin/sccache";
      };
    };
  };
}
