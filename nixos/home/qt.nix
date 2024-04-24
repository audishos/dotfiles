# RAGEQUIT! 😡
{ lib, pkgs, ... }:
let
  variant = "Mocha";
  accent = "Mauve";
  variantLower = lib.strings.toLower variant;
  accentLower = lib.strings.toLower accent;
  themeName = "Catppuccin-${variant}-${accent}";
  kvantumThemePackage = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
in
{
  home = {
    packages = with pkgs; [
      papirus-folders
      kvantumThemePackage
      kdePackages.dolphin
      # kdePackages.breeze
      libsForQt5.qt5ct
      kdePackages.qt6ct
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.qtstyleplugin-kvantum
      # catppuccin-qt5ct
      # catppuccin-kde
    ];

    # sessionVariables = {
    #   QT_QPA_PLATFORMTHEME = "qt5ct";
    #   QT_QPA_PLATFORM = "wayland";
    #   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    #   QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    #   QT_STYLE_OVERRIDE = "breeze";
    # };

    # Cursor setup
    pointerCursor = {
      name = "${themeName}-Cursors";
      package = pkgs.catppuccin-cursors.mochaLavender;
      gtk.enable = true;
      # size = machine.seat.cursorSize;
    };
  };

  systemd.user.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # GTK Setup
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "${themeName}-Standard";
  #     package = pkgs.catppuccin-gtk.override {
  #       accents = [ accentLower ];
  #       size = "standard";
  #       variant = variantLower;
  #     };
  #   };
  #   iconTheme = {
  #     name = "${themeName}-Papirus";
  #     package = pkgs.catppuccin-papirus-folders.override {
  #       flavor = variantLower;
  #       accent = accentLower;
  #     };
  #   };
  #   cursorTheme = {
  #     name = "Catppuccin-Mocha-Lavender-Cursors";
  #     package = pkgs.catppuccin-cursors.mochaLavender;
  #   };
  #   gtk3 = {
  #     # bookmarks = [
  #     #   "file:///home/h/projects"
  #     #   "file:///home/h/drive/Fotos"
  #     #   "file:///tmp"
  #     # ];
  #     extraConfig.gtk-application-prefer-dark-theme = true;
  #   };
  # };
  # dconf.settings = {
  #   "org/gtk/settings/file-chooser" = {
  #     sort-directories-first = true;
  #   };
  #
  #   # GTK4 Setup
  #   "org/gnome/desktop/interface" = {
  #     gtk-theme = "${themeName}-Standard";
  #     color-scheme = "prefer-dark";
  #   };
  # };

  xdg.configFile = {
    kvantum = {
      target = "Kvantum/kvantum.kvconfig";
      text = lib.generators.toINI { } {
        General.theme = themeName;
      };
    };

    qt5ct = {
      target = "qt5ct/qt5ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "${themeName}-Papirus";
        };
      };
    };

    qt6ct = {
      target = "qt6ct/qt6ct.conf";
      text = lib.generators.toINI { } {
        Appearance = {
          icon_theme = "${themeName}-Papirus";
        };
      };
    };
  };
  # xdg.configFile = {
  #   "Kvantum/kvantum.kvconfig".text = ''
  #     [General]
  #     theme=Catppuccin-${variant}-${accent}
  #   '';
  #
  #   # The important bit is here, links the theme directory from the package to a directory under `~/.config`
  #   # where Kvantum should find it.
  #   "Kvantum/Catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/Catppuccin-${variant}-${accent}";
  # };
  # xdg.configFile = {
  #   "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
  #     General.theme = "Catppuccin-${variant}-${accent}";
  #   };
  #
  #   "Kvantum/Catppuccin-${variant}-${accent}".source = "${kvantumThemePackage}/share/Kvantum/Catppuccin-${variant}-${accent}";
  # };
}

