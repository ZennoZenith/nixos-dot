export def --env load_keychian [] {
  let hostname = (cat /etc/hostname)
  let keychain_env_file = $'($nu.home-path)/.keychain/($hostname)-sh'

  if not ( $keychain_env_file | path exists ) {
    return
  } 

  # eg:
  ## ~/.keychain/hostname-fish
  # set -e SSH_AUTH_SOCK; set -x -U SSH_AUTH_SOCK /tmp/ssh-XXXXXXzzE1oz/agent.96531;
  # set -e SSH_AGENT_PID; set -x -U SSH_AGENT_PID 96532;
   
  ## ~/.keychain/hostname-sh
  # SSH_AUTH_SOCK=/tmp/ssh-XXXXXX5liZE1/agent.1561; export SSH_AUTH_SOCK;
  # SSH_AGENT_PID=1562; export SSH_AGENT_PID;

 open --raw $keychain_env_file
    | lines
    | parse "{k}={v}; export {k2};"
    | select k v
    | transpose --header-row
    | into record
    | load-env
}


export def --env sshr [ssh_keys?: list<string>] {
  ## Updates keychain_env_file with latest env values
  keychain --quiet
  load_keychian 
  
  let ssh_keys = ls -s $'($nu.home-path)/.ssh' | get name | where { |s| ($s | str ends-with '.pub') } | each { $in | str replace ".pub" "" | $"ssh_key: ($in)" }

  let gpg_keys = gpg --with-colons --list-secret-keys --keyid-format LONG | lines | each { split column ":" } | reduce {|it| append $it} | where $it.column1 == "uid" | get column10 | each { $"gpg_uid: ($in)"} 

  let results =  $ssh_keys | append $gpg_keys
    | to text
    | fzf --no-sort --multi
    | lines
    | each {
      |v|
      if ($v | str starts-with "gpg_uid: ") {
        $v | str replace "gpg_uid: " "" | parse --regex '<([^>]+)>' | get capture0 | first
      } else if ($v | str starts-with "ssh_key: ") {
        $v | str replace "ssh_key: " "" 
      } else {
        $v
      }
    }

  keychain --quiet ...$results
}

