#!/usr/bin/env

let s = pamixer --list-sinks
let ids = ($s | awk -F'"' 'NR > 1 {print $1}' | lines)
let names = ($s | awk -F'"' 'NR > 1 {print $6}' | lines)

let selected = $names | to text | tofi -c $'($nu.home-path)/.config/tofi/configV'
let selected_index = $names | enumerate | where ($it.item == $selected) | get index

if ($selected_index | length) == 1 {
  let sink_id = ($ids| get $selected_index.0) 
  pactl set-default-sink $sink_id
}


