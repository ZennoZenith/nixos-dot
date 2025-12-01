export def zll [
  layout?: string
  session?: string
  --default (-d)
] {
  let layouts = (
    ls ~/.config/zellij/layouts/
    | get name
    | each { $in | path basename  }
    | where { $in | str ends-with '.kdl' }
    | each { $in | str replace '.kdl' '' }
  )

  let layout = (
    if $default { "default" }
    else if ($layout != null) { $layout }
    else {
      $layouts | str join "\n" | fzf
    }
  )

  if ($session == null) {
    zellij --new-session-with-layout $layout
  } else {
    zellij --new-session-with-layout $layout --session $session
  }

}

export def zl [
  session?: string
] {
  zll "coding" $session
}

export def zls [] {
  zellij list-sessions
}

export def zla [
  session?: string
] {
  let session = if ($session != null) { $session } else {
    zellij list-sessions --no-formatting | fzf | cut -d' ' -f1
  }

  if ($session | str length) == 0 {
    print "Canceled"
    return null
  }
  
  zellij attach $session
}

export def zld [
  session?: string
  --force (-f)
] {
  let session = if ($session != null) { $session } else {
    zellij list-sessions --no-formatting | fzf | cut -d' ' -f1
  }

  if ($session | str length) == 0 {
    print "Canceled"
    return null
  }

  if ($force) {
    zellij delete-session $session --force
  } else {
    zellij delete-session $session
  }
}

export def zlk [
  session?: string
  --force (-f)
] {
  let session = if ($session != null) { $session } else {
    zellij list-sessions --no-formatting | fzf | cut -d' ' -f1
  }

  if ($session | str length) == 0 {
    print "Canceled"
    return null
  }

  if ($force) {
    zellij kill-session $session --force
  } else {
    zellij kill-session $session
  }
}

export def zlda [
  --force (-f)
] {
  if ($force) {
    zellij delete-all-sessions --force
  } else {
    zellij delete-all-sessions
  }
}

export def zlka [
  --force (-f)
] {
  if ($force) {
    zellij kill-all-sessions --force
  } else {
    zellij kill-all-sessions
  }
}
