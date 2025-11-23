#!/usr/bin/env nu
 
const log_file = "~/nixos-switch.log"
const nixos_dot = "~/nixos-dot"
const hostname = "knacknix"
const flake_path = $"($nixos_dot | path expand)#($hostname)"

use std/dirs

dirs add ~/nixos-dot

## formatting nix files
alejandra . e+o>| save -a /dev/null
jj diff **/*.nix | diffnav 

try {
    let gen = (nixos-rebuild list-generations | detect columns  | where Current == "True" | get Generation.0 | into int)
    let gen = ($gen + 1 | fill -a right -c '0' -w 3)

    jj commit -m $"Generation ($gen)"

    print "NixOS Rebuilding..."
    sudo nixos-rebuild switch --flake $flake_path 

    if ($env.LAST_EXIT_CODE != 0) {
        error make { msg: "nixos-rebuild switch failed" }
    }

    # print "NixOS Switching..."
    # sudo nixos-rebuild switch --flake $flake_path 
} catch {
    jj edit -r @-
}
dirs drop 
