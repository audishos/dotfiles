{ catppuccinWaybar, ... }:
{
  programs.waybar.enable = true;

  # Copy catppuccin css files to config dir
  xdg.configFile."waybar" = {
    source = "${catppuccinWaybar}/themes";
    recursive = true;
  };
}
