#!/usr/bin/env nu

const VOL_FILE = $"($nu.home-path)/.cache/osd/volume"
const BRIT_FILE = $"($nu.home-path)/.cache/osd/brightness"

## Fibonacci series: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34
const SERIES = [1 1 2 3 5 8 13 21 34]
# const SERIES_MAX_INDEX =  8 # (($SERIES | length) - 1)
const THRESHOLD_MS = 0.250

def read_value [file_path: string] {
  let file_content = (open --raw $file_path | lines)
  let prev_time = ($file_content.0 | into float)
  let x_val = ($file_content.1 | into int)
  let prev_action = ($file_content.2)

  
  return {
    time: $prev_time
    x_val: $x_val
    action: $prev_action
  }
}

def write_value [
  file_path: string
  time: float
  x_val: int
  action:string = "inc"
] {
  $"($time)\n($x_val)\n($action)" | save -f $file_path
}

def init [value: string] {
  let now = (date now | format date "%s.%f" | into float) 
  const action = "inc"
  match $value {
    "volume" => {
      mkdir $VOL_DIR
      write_value $VOL_FILE $now 0 "inc"
    }
    "brightness" => {
      mkdir $BRIT_DIR
      write_value $BRIT_FILE $now 0 "inc"
    }
  }
}

def limit [value min max] {
  if $value < $min {
    return $min
  } else if $value > $max {
    return $max
  } else {
    return $value
  }
}

def volume_action [x_val_index: int action: string] {
  let current_vol = (
    wpctl get-volume @DEFAULT_AUDIO_SINK@
    | split row " " | last | into float
  ) * 100
  let add_value = ($SERIES | get $x_val_index)

  let next_vol_val = if $action == "inc" {
    ($current_vol + $add_value)
  } else {
    ($current_vol - $add_value)
  }

  let $next_vol_val = limit $next_vol_val 0 150
  wpctl set-volume @DEFAULT_AUDIO_SINK@ ($next_vol_val / 100)
}

def brit_action [x_val_index: int action: string] {
  let MAX_BRIT = (brightnessctl m | into int)
  let current_brit = (brightnessctl g | into int)
  let current_brit = ($current_brit / $MAX_BRIT) * 100
  let current_brit = ($current_brit | into int)

  let add_value = ($SERIES | get $x_val_index)

  let next_val = if $action == "inc" {
    ($current_brit + $add_value)
  } else {
    ($current_brit - $add_value)
  }

  let $next_val = limit $next_val 0 100
  brightnessctl s $"($next_val)%"
}

def volume [action: string = "inc"] {
  if not ($VOL_FILE | path exists) {
    init volume
  }

  if not ($action != "inc" or $action != "dec") {
    return 1
  }

  let prev = read_value $VOL_FILE
  let now = (date now | format date "%s.%f" | into float)
  let diff = ($now - $prev.time) 
  let prev_action = $prev.action
  let prev_x_val = $prev.x_val

  let next_x_val = if $action != $prev_action {
    0
  } else if $diff > $THRESHOLD_MS {
    1
  } else {
    let next_x_val = if $prev_x_val >= $SERIES_MAX_INDEX {
      $prev_x_val
    } else {
      $prev_x_val + 1
    }
    $next_x_val
  }
  volume_action $next_x_val $action
  write_value $VOL_FILE $now $next_x_val $action 
}



def brightness [action: string = "inc"] {
  if not ($BRIT_FILE | path exists) {
    init brightness
  }

  if not ($action != "inc" or $action != "dec") {
    return 1
  }

  let prev = read_value $BRIT_FILE
  let now = (date now | format date "%s.%f" | into float)
  let diff = ($now - $prev.time) 
  let prev_action = $prev.action
  let prev_x_val = $prev.x_val

  let next_x_val = if $action != $prev_action {
    0
  } else if $diff > $THRESHOLD_MS {
    1
  } else {
    let next_x_val = if $prev_x_val >= $SERIES_MAX_INDEX {
      $prev_x_val
    } else {
      $prev_x_val + 1
    }
    $next_x_val
  }
  brit_action $next_x_val $action
  write_value $BRIT_FILE $now $next_x_val $action 
}

export def main [value: string action: string = "inc"] {
  match $value {
    "volume" => {
      volume $action
    }
    "brightness" => {
      brightness $action
    }
    _ => {
      print "invalid value"
    }
  }

}


