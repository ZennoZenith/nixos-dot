# https://www.postgresql.org/docs/current/app-pgdump.html
def db_dump [
  database_name: string
  --host (-h): string
  --port (-p): number
  --user (-U): string
  --file-name (-f): string
  --schema-only (-s)
  --clean (-c)
  --data-only (-a)
  --create (-C)
] {
  let host = if ($host == null) {
    'localhost'
  } else {
    $host
  }

  let port = if ($port == null) {
    '5432'
  } else {
    $port
  }

  let user = if ($user == null) {
    'postgres'
  } else {
    $user

  }

  let file_name = if ($file_name == null) {
    'backup'
  } else {
    $file_name
  }

  pg_dump -U $user -p $port -h $host -f $'($file_name)_create.dump' $database_name -Fc

  if $create {
    # create database statement: -C OR --create
    # Begin the output with a command to create the database itself and reconnect to the created database.
    pg_dump -C -U $user -p $port -h $host -f $'($file_name)_create.dump' $database_name -Fc
  }
  
  if $schema_only {
    # Schema only: --schema-only OR -s
    pg_dump -s -U $user -p $port -h $host -f $'($file_name)_schema_only.dump' $database_name -Fc
  }
  
  if $clean {
    # drop database before creating: --clean OR -c
    pg_dump -c -U $user -p $port -h $host -f $'($file_name)_clean_dump.dump' $database_name -Fc
  }
  
  if $data_only {
    # data only: -a OR --data-only
    pg_dump -a -U $user -p $port -h $host -f $'($file_name)_data_only.dump' $database_name -Fc
  }

}

def db_restore [
  database_name: string
  --file-name (-f): string
  --host (-h): string
  --port (-p): number
  --user (-U): string
] {
  let host = if ($host == null) {
    'localhost'
  } else {
    $host
  }

  let port = if ($port == null) {
    '5432'
  } else {
    $port
  }

  let user = if ($user == null) {
    'postgres'
  } else {
    $user

  }

  let file_name = if ($file_name == null) {
    'backup.dump'
  } else {
    $file_name
  }

  pg_restore -d $database_name -U $user -p $port -h $host -C $file_name
}
