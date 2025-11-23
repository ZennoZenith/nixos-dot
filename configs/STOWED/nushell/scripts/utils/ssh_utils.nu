use std log

export def "ssh-keygen" [] {
  let typ = ["default(ed25519)" dsa  ecdsa  ecdsa-sk  ed25519  ed25519-sk  rsa] | input list -f "Key type:"
  let typ = if $typ == "default(ed25519)" { "ed25519" } else { $typ }
  print $"Key type: ($typ)"

  let bits = ["default(4096)" "1024" "2048" "4096"] | input list -f "Bits:"
  let bits = if $bits == "default(4096)" { "4096" } else { $bits }
  print $"Bits: ($bits)"

  let comment = input "Comment: "

  let file_path = input "File path: "

  let passphrase = input -s "Passphrase: "
 
  ^ssh-keygen -t $typ -b $bits -C $comment -f $file_path -N $passphrase
 }
