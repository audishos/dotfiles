{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    sway.enable = true;

    name = "mochaGreen";
    package = pkgs.catppuccin-cursors.mochaGreen;
  };

  # sway config generation contains a dependency on this value
  # https://github.com/nix-community/home-manager/blob/master/modules/config/home-cursor.nix#L251
  gtk.cursorTheme.size = 32;
}
