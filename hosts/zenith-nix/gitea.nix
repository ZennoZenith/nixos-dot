{...}: {
  # services.nginx = {
  #   enable = true;

  #   virtualHosts."git.example.com" = {
  #     enableACME = true;
  #     forceSSL = true;

  #     locations."/" = {
  #       proxyPass = "http://127.0.0.1:3000";
  #     };
  #   };
  # };

  # services.gitea = {
  #   enable = true;

  #   appName = "My Gitea";

  #   # database = {
  #   #   type = "postgres";
  #   #   name = "gitea";
  #   #   user = "gitea";
  #   # };

  #   database.type = "sqlite3";

  #   # captcha = {
  #   #   enable = true;
  #   #   requireForExternalRegistration = true;
  #   # };

  #   settings = {
  #     server = {
  #       DOMAIN = "localhost";
  #       HTTP_PORT = 9999;
  #       ROOT_URL = "http://localhost:9999/";
  #       SSH_DOMAIN = "localhost";
  #     };

  #     service = {
  #       DISABLE_REGISTRATION = true;
  #     };
  #   };

  #   #settings.service.DISABLE_REGISTRATION = true;
  # };
}
