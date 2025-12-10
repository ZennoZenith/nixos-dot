# https://github.com/junegunn/fzf
fzf --style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'

fzf --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'
