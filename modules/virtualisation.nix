{ config, pkgs, ... }:

# QEMU/KVM virtualisation through libvirt, driven from the virt-manager GUI.
# Guests are attached to the libvirt "default" network (bridge virbr0), which
# gives them an address over DHCP plus NAT and DNS out through the host.
{
  virtualisation.libvirtd.enable = true;

  # The GUI, preconfigured to connect to the local qemu:///system instance.
  programs.virt-manager.enable = true;

  # virt-manager keeps its connections in dconf and the module above seeds them
  # through /etc/dconf/profile/user, which is only read with the dconf GSettings
  # backend present.
  programs.dconf.enable = true;

  # Membership of "libvirtd" is what the polkit rule installed by the libvirtd
  # module looks for, so virt-manager authenticates without a password prompt.
  users.groups.libvirtd.members = [ "femboy" ];

  # The NixOS firewall drops host bound traffic by default. libvirt filters the
  # guest -> internet path on its own, trusting the bridge additionally keeps
  # guest -> host traffic (DNS to the host, SSH, ping) working.
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # libvirt ships the definition of the "default" network, but the autostart
  # symlink libvirt creates for it is not part of the copied configuration on
  # NixOS, so the network has to be activated and flagged for autostart once.
  # Doing it here keeps that step declarative instead of asking for a manual
  # `virsh net-autostart default` after every reinstall.
  systemd.services.libvirtd-default-network = {
    description = "Start the libvirt default NAT network and mark it for autostart";
    wantedBy = [ "multi-user.target" ];
    after = [ "libvirtd.service" ];
    wants = [ "libvirtd.service" ];

    environment.LIBVIRT_DEFAULT_URI = "qemu:///system";
    path = [ config.virtualisation.libvirtd.package ];
    serviceConfig.Type = "oneshot";
    restartIfChanged = false;

    script = ''
      # Persistent: libvirtd brings the network up on every later boot.
      virsh net-autostart default

      # Transient: only needed while it is not running yet, which is the case
      # right after the first boot with this configuration.
      if ! virsh net-list --name | grep -qx default; then
        virsh net-start default
      fi
    '';
  };
}
