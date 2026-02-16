{pkgs, ...}: {
  # Enable KVM (hardware virtualization)
  virtualisation.libvirtd.enable = true;

  # Optional: enable QEMU + GUI tools
  programs.virt-manager.enable = true;

  # Allow your user to manage VMs
  users.users.zenith.extraGroups = ["libvirtd" "kvm"];

  # Optional: better performance for networking
  virtualisation.spiceUSBRedirection.enable = true;

  # Recommended packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    qemu
  ];
}
