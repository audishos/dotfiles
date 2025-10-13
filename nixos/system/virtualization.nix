{
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  users.extraUsers.audisho.extraGroups = ["libvirtd" "docker"];

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';
}
