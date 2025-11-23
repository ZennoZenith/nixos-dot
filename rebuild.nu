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

$env.commit_revset = ""
try {
    let gen = (nixos-rebuild list-generations | detect columns  | where Current == "True" | get Generation.0 | into int)
    let gen = ($gen + 1 | fill -a right -c '0' -w 3)
    let jj_output = (jj commit -m $"Generation ($gen)")
    $env.commit_revset = ($jj_output | grep "Parent commit" | split chars | slice 26..33 | str join)

    print "NixOS Rebuilding..."
    sudo nixos-rebuild switch --flake $flake_path o+e>| save -f $log_file
    if ($env.LAST_EXIT_CODE != 0) {
        error make { msg: "nixos-rebuild switch failed" }
    }
} catch {
    if ( $env.commit_revset != "" ) {
      jj edit -r $env.commit_revset
    }

    # if ($log_file | path exists) {
    #     open $log_file 
    #     | lines 
    #     | where $it =~ "error" 
    #     | each { |line| print -e $"($line)" }
    #     error make { msg: "nixos-rebuild switch failed. See errors above." }
    # } else {
    #     error make { msg: "nixos-rebuild switch failed, but log file not found." }
    # }
}

dirs drop 
