{...}: {
  services.nginx.enable = true;

  services.nginx.virtualHosts."immich.zennozenith.com" = {
    # enableACME = true;
    # forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:15000";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };
}
