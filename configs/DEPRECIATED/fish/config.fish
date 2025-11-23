function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

starship init fish | source
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

alias pamcan=pacman

set -g -x EDITOR hx
set -g -x STARSHIP_CONFIG $HOME/.config/starship/starship.toml
set -g -x STARSHIP_SHELL fish

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# ============================= Brew ==========================================
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# ============================= PATH ==========================================
fish_add_path -m ~/.local/bin

# ============================= Bat ===========================================
set -x MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
alias bathelp='bat --plain --language=help'

# ============================= Atuin =========================================
set -gx ATUIN_NOBIND true
atuin init fish | source

# bind to ctrl-r in normal and insert mode, add any other bindings you want here too
bind \cr _atuin_search
bind -M insert \cr _atuin_search

# ============================= Zoxide ========================================
zoxide init fish | source
set -gx _ZO_DATA_DIR $HOME/.local/share/zoxide

# ============================= Lazygit ========================================
alias lg=lazygit
