{ pkgs, ... }:
{
  # home.sessionVariables.QT_QPA_PLATFORMTHEME = "qt5ct";

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.package = pkgs.catppuccin-qt5ct;
  };

  xdg.configFile = {
    "qt5ct/colors/Catppuccin-Frappe.conf".source = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/Catppuccin-Frappe.conf";
    "qt5ct/colors/Catppuccin-Latte.conf".source = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/Catppuccin-Latte.conf";
    "qt5ct/colors/Catppuccin-Macchiato.conf".source = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/Catppuccin-Macchiato.conf";
    "qt5ct/colors/Catppuccin-Mocha.conf".source = "${pkgs.catppuccin-qt5ct}/share/qt5ct/colors/Catppuccin-Mocha.conf";
  };

  home.packages = with pkgs; [
    libsForQt5.breeze-icons
  ];
}
