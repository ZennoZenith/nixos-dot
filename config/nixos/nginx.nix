{...}: {
  services.nginx.enable = false;

  services.nginx.virtualHosts."localhost" = {
    default = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:80";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };

  services.nginx.virtualHosts."*.zennozenith.com" = {
    listen = [
      {
        addr = "0.0.0.0";
        port = 80;
      }
    ];

    locations."/" = {
      proxyPass = "http://127.0.0.1:6188";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };

  # services.nginx.virtualHosts."*.zennozenith.com-ssl" = {
  #   serverName = "*.zennozenith.com";

  #   listen = [
  #     {
  #       addr = "0.0.0.0";
  #       port = 443;
  #       ssl = true;
  #     }
  #   ];

  #   enableACME = true; # remove if you manage certs manually
  #   forceSSL = false; # IMPORTANT: do not redirect HTTP → HTTPS

  #   locations."/" = {
  #     proxyPass = "http://127.0.0.1:6189";
  #     proxyWebsockets = true;
  #     recommendedProxySettings = true;
  #   };
  # };

  services.nginx.streamConfig = ''
    map $ssl_preread_server_name $upstream {
      ~^(.+)\.zennozenith\.com$ 127.0.0.1:6189;
      default                    127.0.0.1:6189;
    }

    server {
      listen 443;
      proxy_pass $upstream;
      ssl_preread on;

      ## Add this line:
      # proxy_protocol on;

      # Optional: increase timeouts for long-lived connections (like websockets)
      proxy_connect_timeout 5s;
      proxy_timeout 1h;
    }
  '';

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

  services.nginx.virtualHosts."jellyfin.zennozenith.com" = {
    # enableACME = true;
    # forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8096";
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
