{variables, ...}: {
  services.cloudflared = {
    enable = true;
    certificateFile = "${variables.home.homeDirectory}/.cloudflared/cert.pem";
    tunnels = {
      "19d72a3d-c921-49a0-bb13-0432934ca681" = {
        credentialsFile = "${variables.home.homeDirectory}/.cloudflared/19d72a3d-c921-49a0-bb13-0432934ca681.json";
        ingress = {
          "pixiutech.com" = "http://localhost:80";
        };
        default = "http_status:404";
      };
    };
  };
}
