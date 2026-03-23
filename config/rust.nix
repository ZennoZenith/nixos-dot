{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Rust (ONLY rustup)
    rustup

    # Build tools
    pkg-config
    gcc
    clang
    llvmPackages.bintools # lld

    # Libraries
    openssl

    # Dev tools
    sccache
    mold
    bacon
  ];
}
