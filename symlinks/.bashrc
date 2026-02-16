

# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias -- btw='echo i use nixos, btw'
alias -- eza='eza --icons always --git --group-directories-first --no-quotes --header --git-ignore --classify --hyperlink'
alias -- la='eza -a'
alias -- ll='eza -l'
alias -- lla='eza -la'
alias -- ls=eza
alias -- lt='eza --tree'
alias -- nd='nix develop -c nu'

if [[ -n "${GHOSTTY_RESOURCES_DIR}" ]]; then
  builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  if cwd="$(<"$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

source "~/.config/bash/wezterm-profile.sh"

if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="no-rc enabled"
  source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi

eval "$(SHELL=bash keychain --eval --quiet github knack linode zenith)"

if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
  source "~/.config/bash/bash-preexec.sh"
  eval "$(atuin init bash)"
fi

GPG_TTY="$(tty)"
export GPG_TTY
gpg-connect-agent --quiet updatestartuptty /bye > /dev/null

eval "$(zoxide init bash --cmd cd)"
