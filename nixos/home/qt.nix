{ pkgs, ... }:
{
  # home = {
  #   sessionVariables = {
  #     QT_QPA_PLATFORMTHEME = lib.mkForce "qtct";
  #     QT_QPA_PLATFORM = "wayland";
  #     QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  #     QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  #   };
  # };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita";
    };
  };
}
