let host = $nu.os-info | get name 

if $host == 'windows' {
  $env.ALACRITTY_CONFIG_PATH = $'($nu.home-path)\AppData\Roaming\alacritty'
} else if $host == 'linux' {
  $env.ALACRITTY_CONFIG_PATH = $'($nu.home-path)/.config/alacritty'
}
