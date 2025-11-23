def starship-theme [] {
  ls -s ~/.config/starship/themes | select name
}

export def "starship-theme create" [] {
  let themes = starship preset -l | lines 
  for $theme in $themes {
    if ( $theme | is-empty ) {
      continue
    }

    mkdir ~/.config/starship/themes
    starship preset $theme -o $'($nu.home-path)/.config/starship/themes/_default-($theme).toml'
    print $'Create ($theme)'
  }  
}

def "starship-theme set" [] {
  
}
