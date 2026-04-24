#!/usr/bin/nu

let touchpad_state_file = $'($env.XDG_RUNTIME_DIR | default $'/run/user/$(id -u)')/touchpad.status'

if ($touchpad_state_file | path type) != 'file' {
  print $"($touchpad_state_file) does not exist or is not a file"
  ^mkdir -p ($touchpad_state_file | path dirname)
  save_state_to_file 'true'
}

def save_state_to_file [state: string]: nothing -> string {
    let state = if ($state | str trim | str downcase ) == 'true' {
      'true'  
    } else {
      'false'
    }
    $state | save -f $touchpad_state_file
    return $state
}

def get_state_from_file []: nothing -> string {
  let file_lines = open $touchpad_state_file --raw | lines
  if ($file_lines | is-empty) {
    print $"($touchpad_state_file) is empty"
    save_state_to_file 'true'
    return true
  }

  if ($file_lines | get 0 | str trim | str downcase ) == 'true' {
    return true  
  }
  return false
}

def set_state [state: bool] {
    let state = $state | into string
    let state = save_state_to_file $state
    hyprctl keyword 'device[synps/2-synaptics-touchpad]:enabled' $state
}


def main [state?: bool] {
  # If state is given
  if ($state != null) {
    set_state (not $state)
    return
  } 

  # Else toggle state
  set_state (not (get_state_from_file | into bool))
}
