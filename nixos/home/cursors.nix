{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    # sway.enable = true;

    name = "mochaGreen";
    package = pkgs.catppuccin-cursors.mochaGreen;
  };
}
