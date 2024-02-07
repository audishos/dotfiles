{ catppuccinWaybar, ... }:
{
  programs.waybar = {
    enable = true;
    style = ''
      @import "mocha.css";

      * {
        font-family: FiraCode Nerd Font Mono;
        font-size: 1.1rem;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background-color: @base;
        margin: 0 16px;
        padding: 0 16px;
        border-radius: 24px;
      }

      window#waybar {
        color: @text;
        background-color: transparent;
      }

      #workspaces button {
        color: @text;
        border-radius: 32px;
      }

      #workspaces button.focused,
      #workspaces button.active,
      #workspaces button.visible {
        background-color: @green;
        color: @crust;
        box-shadow: inset 0 -4px @maroon;
      }

      #idle_inhibitor {
        font-size: 2rem;
      }
    '';
  };

  # Copy catppuccin css files to config dir
  xdg.configFile."waybar" = {
    source = "${catppuccinWaybar}/themes";
    recursive = true;
  };
}
