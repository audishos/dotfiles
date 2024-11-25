{lib, ...}: {
  home.sessionVariables = {
    XDG_DATA_DIRS = lib.mkForce "$XDG_DATA_DIRS\${XDG_DATA_DIRS:+:}/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/nix/store/01yrs1xxqfbhq9i9ihyixw3cyrhh4gd3-network-manager-applet-1.36.0/share";
  };
}
