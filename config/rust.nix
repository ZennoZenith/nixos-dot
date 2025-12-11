{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rustup
    cargo
    sccache
    mold
    llvmPackages.bintools ## lld
  ];
}
