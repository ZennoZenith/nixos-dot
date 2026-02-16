alias ll = ls -l
alias la = ls -a

alias lg = lazygit
alias lj = lazyjj
alias bt = btop --force-utf

alias tt = taskwarrior-tui

# =============================== bat =========================================
alias b = bat
alias bn = bat --number
alias bnl = bat --number --line-range
alias bp = bat --plain
alias bpl = bat --plain --line-range
alias bl = bat --line-range
alias bh = bat --plain --theme="ansi" --language=help
alias bathelp = bat --plain --theme="ansi" --language=help

# =============================== eza =========================================
export alias x = eza --icons --group-directories-first --no-quotes --header --git-ignore --classify --hyperlink
export alias xa = x --all
export alias xl	= x --long
export alias xla = x --long --all
export alias xt	= x --tree
export alias xta = x --tree --all
 
# =============================== qrtool ======================================
export alias qre = qrtool encode -t ansi

# =============================== gtrash ======================================
# export alias gp = gtrash put # gtrash put
# export alias gm = gtrash put # gtrash move (easy to change to rm)
# export alias tp = gtrash put # trash put
export alias tm = gtrash put # trash move (easy to change to rm)
# export alias tt = gtrash put # to trash

# =============================== git =========================================
# source ~/dotfiles/.config/nushell/scripts/git/alias.nu
