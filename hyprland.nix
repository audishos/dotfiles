{ config, pkgs, ... }:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager = {
    users.audisho = { pkgs, ... }: {
      home = {
        packages = with pkgs; [
          swaylock
          swayidle
          wl-clipboard
          # tofi
          mako
          alacritty
          pavucontrol
          dbus-sway-environment
          configure-gtk
          xdg-utils
          glib
          dracula-theme
          gnome3.adwaita-icon-theme
          grim
          slurp
          wdisplays
        ];
      };

      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        xwayland.enable = false;
      };
    };
  };
}
