{pkgs, ...}: {
  home.packages = with pkgs; [
    steam-tui
    steamcmd
    lutris
  ];
}
