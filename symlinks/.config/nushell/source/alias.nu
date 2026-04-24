alias nd = nix develop -c nu
alias bt = btop
alias lg = lazygit
alias lj = lazyjj
alias ld = lazydocker
alias fzi = fzf --style full --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'
def --env star [] {
  ls -f ~/.config/starship/themes | get name | to text | fzf | $env.STARSHIP_CONFIG = $in
} 

# ─────────────────────────────── bat ─────────────────────────────────────────
alias b = bat
alias bn = bat --number
alias bnl = bat --number --line-range
alias bp = bat --plain
alias bpl = bat --plain --line-range
alias bl = bat --line-range
alias bh = bat --plain --theme="ansi" --language=help
alias bathelp = bat --plain --theme="ansi" --language=help

# ─────────────────────────────── eza ─────────────────────────────────────────
# eza --icons --group-directories-first --no-quotes --header --git-ignore --classify --hyperlink -l --tree -all
export alias x = eza --icons
export alias xa = eza --icons --all
export alias xl	= eza --long
export alias xla = eza --long --all
export alias xt	= eza --icons --tree
export alias xta = eza --icons --tree --all
 
# ─────────────────────────────── qrtool ──────────────────────────────────────
export alias qre = qrtool encode -t ansi
