# ============================= Alacritty =====================================
# let host = $nu.os-info | get name 
# mut alacritty_config_path = ''
# if $host == 'windows' {
#   $alacritty_config_path = $'C:\Users\($env.USERNAME)\AppData\Roaming\alacritty'
# } else if $host == 'linux' {
#   $alacritty_config_path = $'/home/($env.USERNAME)/.config/alacritty'
# }

# if $alacritty_config_path == '' {
#   exit
# }

# let import_list = open $'($env.ALACRITTY_CONFIG_PATH)\alacritty.toml' | get import 
# mut current_theme = ''
# # $import_list | each { 
# #   print $in
# # }


def theme-names [] {
  let import_list = open $'($env.ALACRITTY_CONFIG_PATH)\alacritty.toml' | get import 
  mut current_theme = ''
  # $import_list | each { 
  #   print $in
  # }

  ls -s ([ $nu.home-path .config alacritty themes ] | path join) | get name 
}

export def select-theme [theme_name: string@theme-names] {
  # theme-names
  print $theme_name
}
