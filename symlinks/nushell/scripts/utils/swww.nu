#!/usr/bin/nu
const swww_last_background_file = $'($nu.home-path)/.local/share/swww/swww-last-background'
const background_images_dir = $'($nu.home-path)/assets/backgrounds'
const transistion_effects = [ simple | fade | left | right | top | bottom | wipe | wave | grow | center ]
# possible_transistion_effects =  none | simple | fade | left | right | top | bottom | wipe | wave | grow | center | any | outer | random
 
let swww_transition_fps = ($env | get --ignore-errors SWWW_TRANSITION_FPS  | default 255)
let swww_transition_duration = ($env | get --ignore-errors SWWW_TRANSITION_DURATION | default 1.5)


def set_swww_image [
  image: string
  --init
] {
  let random_x =  random float | math round --precision 3
  let random_y =  random float | math round --precision 3


  let transistion_effects_length = $transistion_effects | length
  let effect = $transistion_effects | get (random int 0..($transistion_effects_length - 1))

  if $init {
    swww img --transition-type outer --transition-duration $swww_transition_duration --transition-fps $swww_transition_fps $image 
  } else {
    # --transition-type grow
    swww img --transition-type $effect --transition-pos $'($random_x),($random_y)' --transition-duration $swww_transition_duration --transition-fps $swww_transition_fps $image 
  }
}    

def save_image_to_last_file [image: string] {
  if not ($swww_last_background_file | path exists ) {
    ^mkdir -p ($swww_last_background_file | path dirname)
  }
  $image | save -f $swww_last_background_file 
}


def check_background_images_dir [] {
  if ($background_images_dir | path type) != 'dir' {
    print $"($background_images_dir) does not exist"
    return null
  }

  let images = ls -af $background_images_dir | where type == 'file' | get name | sort | enumerate

  if ($images | is-empty) {
    print $"($background_images_dir) is empty"
    return null
  }

  return $images
}

def check_swww_last_background_file [] {
  if ($swww_last_background_file | path type) != 'file' {
    print $"($swww_last_background_file) does not exist or is not a file"
    return null
  }
  
  let file_lines = open $swww_last_background_file --raw | lines
  if ($file_lines | is-empty) {
    print $"($swww_last_background_file) is empty"
    return null
  }

  return ($file_lines | get 0)
}

def change_by_from_index [index: int] {
  let images = check_background_images_dir 
  if ($images == null) {
    return
  }

  let number_of_images = $images | length

  mut swww_last_image = check_swww_last_background_file
  if ($swww_last_image == null) {
    save_image_to_last_file ($images | get 0 | get item)
    $swww_last_image = $images | get 0 | get item
  }

  let image = $images | where $it.item == $swww_last_image

  if ($image | is-empty) {
    set_swww_image ($images | get 0 | get item)
    save_image_to_last_file ($images | get 0 | get item)
    return
  } 

  let new_index = $index + $image.0.index
  let mod_index = if $new_index >= 0 {
    $new_index mod $number_of_images 
  } else {
    # HACK: assuming new index is not less than $number_of_images
    ($new_index + $number_of_images) mod $number_of_images 
  }

  let next_image = $images | get $mod_index | get item

  set_swww_image $next_image 
  save_image_to_last_file $next_image

}

def change_by_select [] {
  let images = check_background_images_dir 
  if ($images == null) {
    return
  }

  mut swww_last_image = check_swww_last_background_file
  if ($swww_last_image == null) {
    save_image_to_last_file ($images | get 0 | get item)
    $swww_last_image = $images | get 0 | get item
  }

  let selected = $images | get item | path basename | to text | tofi -c $'($nu.home-path)/.config/tofi/configV'

  let image = $images | where $it.item == $'($background_images_dir)/($selected)'

  if ($image | is-empty) {
    return
  } 

  let next_image = $image | get 0 | get item
  
  if $next_image != $swww_last_image {
    set_swww_image $next_image
    save_image_to_last_file $next_image
  }
}

def main [] {
  change_by_select
}

def "main next" [] {
  change_by_from_index 1
}

def "main prev" [] {
  change_by_from_index -1
}

