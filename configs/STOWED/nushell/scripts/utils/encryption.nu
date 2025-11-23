use std log

export def "encrypt init" [
  --user (-u): string
] {
  let user = ($user | default $env.user)

  if ((which age | length) < 1) {
    log error 'age is not installed'
    return null
  }

  let secret_private_path = ($nu.home-path | path join $'secrets/($user)/key.txt.age') 
  
  let secret_public_path = ($nu.home-path | path join $'secrets/($user)/key_pub.txt') 
  
  if not ( $secret_private_path | path exists | into bool ) {
    log error $'($secret_private_path) not found'
    return null
    
  }

  if not ( $secret_public_path | path exists | into bool) {
    log error $'($secret_public_path) not found'
    return null
    
  }

  ^mkdir -p $"($nu.home-path)/.config/age"
  
  age -d -o $"($nu.home-path)/.config/age/key.txt" $secret_private_path
  chmod 600 $"($nu.home-path)/.config/age/key.txt"

  cp $secret_public_path $"($nu.home-path)/.config/age/key_pub.txt"
  chmod 644 $"($nu.home-path)/.config/age/key_pub.txt"
}

# age -a -R ~/key_pub.txt -o .ssh/id_ed25519.age ~/.ssh/id_ed25519

def encrypt [
  file_name: string
  # --output (-o): string
  # # --caps # <- boolean

] {
  if ((which age | length) < 1) {
    log error 'age is not installed'
    return null
  }

  if (($file_name | path type) != 'file') {
    log error $'($file_name) is not a file'
    return null
  }

  let public_key_path = ($nu.home-path | path join $'.config/age/key_pub.txt')
 

  age -a -R $public_key_path -o $'($file_name).age' $file_name  

  echo $'Saved as ($file_name).age'
}

export def decrypt [
  file_name: string
  --output (-o): string
  # # --caps # <- boolean

] {

  if ((which age | length) < 1) {
    log error 'age is not installed'
    return null
  }

  if (($file_name | path type) != 'file') {
    log error $'($file_name) is not a file'
    return null
  }

  let output = ($output | default ($file_name | str replace ".age" ""))

  let private_key_path = ($nu.home-path | path join $'.config/age/key.txt')

  age -d -i $private_key_path -o $output $file_name 

  echo $'Saved as ($output)'
}
