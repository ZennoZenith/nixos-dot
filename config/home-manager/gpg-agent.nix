# https://tsawyer87.github.io/posts/gpg-agent_on_nixos/#
{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    custom.gpg-agent = {
      enable = lib.mkEnableOption {
        description = "Enable PGP Gnupgp";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.gpg-agent.enable {
    services = {
      ## Enable gpg-agent with ssh support
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;

        defaultCacheTtl = 86400; ## 86400 sec => 24 hour
        defaultCacheTtlSsh = 86400;

        maxCacheTtl = 86400;
        maxCacheTtlSsh = 86400;

        # pinentry is a collection of simple PIN or passphrase dialogs used for
        # password entry
        ## to reload gpg-agent: `gpg-connect-agent reloadagent /bye`
        pinentry.package = pkgs.pinentry-all;
        # pinentry.package = pkgs.pinentry-tty;
        # pinentry.package = pkgs.pinentry-qt;
      };

      gpg-agent.sshKeys = [
        # "A773ECC1671F32081FFD6893A18022553759159C"
        "539A9075E00CF0209656AF25C985596966F7516C"
      ];
    };
    home.packages = [pkgs.gnupg];
    programs = {
      gpg = {
        ## Enable GnuPG
        enable = true;

        # homedir = "/home/userName/.config/gnupg";
        settings = {
          # Default/trusted key ID (helpful with throw-keyids)
          # Example, you will put your own keyid here
          # Use `gpg --list-keys`
          # default-key = "0x1CDCB4568D6A0051";
          # trusted-key = "0x1CDCB4568D6A0051";
          default-key = "0x99DCA16E0E956F82";
          trusted-key = "0x99DCA16E0E956F82";
          # https://github.com/drduh/config/blob/master/gpg.conf
          # https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration-Options.html
          # https://www.gnupg.org/documentation/manuals/gnupg/GPG-Esoteric-Options.html
          # Some Best Practices, stronger algos etc
          # Use AES256, 192, or 128 as cipher
          personal-cipher-preferences = "AES256 AES192 AES";
          # Use SHA512, 384, or 256 as digest
          personal-digest-preferences = "SHA512 SHA384 SHA256";
          # Use ZLIB, BZIP2, ZIP, or no compression
          personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
          # Default preferences for new keys
          default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
          # SHA512 as digest to sign keys
          cert-digest-algo = "SHA512";
          # SHA512 as digest for symmetric ops
          s2k-digest-algo = "SHA512";
          # AES256 as cipher for symmetric ops
          s2k-cipher-algo = "AES256";
          # UTF-8 support for compatibility
          charset = "utf-8";
          # Show Unix timestamps
          fixed-list-mode = "";
          # No comments in signature
          no-comments = "";
          # No version in signature
          no-emit-version = "";
          # Disable banner
          no-greeting = "";
          # Long hexidecimal key format
          keyid-format = "0xlong";
          # Display UID validity
          list-options = "show-uid-validity";
          verify-options = "show-uid-validity";
          # Display all keys and their fingerprints
          with-fingerprint = "";
          # Cross-certify subkeys are present and valid
          require-cross-certification = "";
          # Disable caching of passphrase for symmetrical ops
          no-symkey-cache = "";
          # Enable smartcard
          # use-agent = "";
        };
      };
    };
  };
}
