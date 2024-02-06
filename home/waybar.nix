
{ waybarConfig, ... }:
{
  programs.waybar.enable = true;

  xdg.configFile."waybar" = {
    source = "${waybarConfig}/config/waybar";
    recursive = true;
  };
}
