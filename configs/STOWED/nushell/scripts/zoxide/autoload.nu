## HACK: some error happens when trying to convert __zoxide_hooked in zoxide init 
$env.ENV_CONVERSIONS.__zoxide_hooked = {
    from_string: { |s| $s | into bool }
    to_string: { |v| $v | into string }
}

# # $env._ZO_ECHO = 1
# $env._ZO_EXCLUDE_DIRS
# $env._ZO_FZF_OPTS
# $env._ZO_MAXAGE
$env._ZO_DATA_DIR = $'($nu.home-path)/.local/share/zoxide'
