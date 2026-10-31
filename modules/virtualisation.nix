{ config, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  programs.dconf.enable = true;

  users.groups.libvirtd.members = [ "larp" ];
  networking.firewall.trustedInterfaces = [ "virbr0" ];

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
      virsh net-autostart default
      if ! virsh net-list --name | grep -qx default; then
        virsh net-start default
      fi
    '';
  };
}
