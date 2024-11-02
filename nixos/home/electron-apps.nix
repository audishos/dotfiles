{pkgs, ...}: let
  electron = pkgs.electron_29;
  vesktop = pkgs.vesktop.override {inherit electron;};
  r2modman = pkgs.r2modman.override {inherit electron;};
  # bruno = pkgs.bruno.override {inherit electron;};
in {
  home.packages = [
    vesktop
    r2modman
    # not building right now 😢
    # bruno
    pkgs.logseq
  ];
}
