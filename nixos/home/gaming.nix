{pkgs, ...}: {
  home.packages = with pkgs; [
    steamcmd
    lutris
  ];
}
