{pkgs, ...}: {
  /*
  ## postgresql.conf
  ```conf
  # WARNING
  # wal_compression = lz4 requires PostgreSQL
  # to be compiled with --with-lz4
  #
  # io_method = io_uring requires PostgreSQL
  # to be compiled with --with-liburing

  # DB Version: 18
  # OS Type: linux
  # DB Type: mixed
  # Total Memory (RAM): 32 GB
  # CPUs num: 6
  # Data Storage: ssd

  max_connections = 100
  shared_buffers = 8GB
  effective_cache_size = 24GB
  maintenance_work_mem = 2GB
  checkpoint_completion_target = 0.9
  wal_buffers = 16MB
  default_statistics_target = 100
  random_page_cost = 1.1
  effective_io_concurrency = 200
  work_mem = 51438kB
  huge_pages = try
  jit = off
  wal_compression = lz4
  autovacuum_work_mem = 2GB
  io_method = io_uring
  min_wal_size = 1GB
  max_wal_size = 4GB
  max_worker_processes = 6
  max_parallel_workers_per_gather = 3
  max_parallel_workers = 6
  max_parallel_maintenance_workers = 3
  ```
  */
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    ensureDatabases = ["mydatabase"];
    enableTCPIP = true;
    identMap = ''
      # ArbitraryMapName systemUser DBUser
         superuser_map      root      postgres
         superuser_map      postgres  postgres
         # Let other names login as themselves
         superuser_map      /^(.*)$   \1
    '';
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method optional_ident_map
      local sameuser  all     peer        map=superuser_map
      local giteadb   gitea   scram-sha-256

      # TCP (no SSL)
      hostnossl giteadb gitea 127.0.0.1/32 scram-sha-256
      hostnossl giteadb gitea ::1/128      scram-sha-256
    '';

    settings = {
      port = 5432;
      password_encryption = "scram-sha-256";

      max_connections = 100;
      shared_buffers = "8GB";
      effective_cache_size = "24GB";
      maintenance_work_mem = "2GB";
      checkpoint_completion_target = 0.9;
      wal_buffers = "16MB";
      default_statistics_target = 100;
      random_page_cost = 1.1;
      effective_io_concurrency = 200;
      work_mem = "51438kB";
      huge_pages = "try";
      jit = "off";
      wal_compression = "lz4";
      autovacuum_work_mem = "2GB";
      io_method = "io_uring";
      min_wal_size = "1GB";
      max_wal_size = "4GB";
      max_worker_processes = 6;
      max_parallel_workers_per_gather = 3;
      max_parallel_workers = 6;
      max_parallel_maintenance_workers = 3;
    };
  };
}
