{ pkgs, ... }:
let
  electron = pkgs.electron_29;
  vesktop = pkgs.vesktop.override { inherit electron; };
in
{
  home.packages = [
    vesktop
  ];
}
