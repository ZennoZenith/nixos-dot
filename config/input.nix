{...}: {
  ## Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
}
