alias nd = nix develop -c nu
alias pp = do {pacman -Qqe | fzf --multi --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'}



