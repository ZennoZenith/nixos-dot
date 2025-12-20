{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rustup
    cargo
    sccache
    mold
    bacon
    llvmPackages.bintools ## lld
  ];
}
