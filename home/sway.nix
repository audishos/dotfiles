{ config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;

    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "wofi --show run --allow-images";
      bars = [{
        command = "waybar";
      }];
      gaps = {
        inner = 8;
        smartBorders = "on";
      };
      window = {
        titlebar = false;
      };
      output."*" = {
        adaptive_sync = "on";
        bg = "/home/audisho/Pictures/wallpaper/dino-extinction.png fill";
      };
      startup = [
        { command = "${pkgs.coreutils}/bin/sleep 5 && ${pkgs.keepassxc}/bin/keepassxc"; }
      ];
      keybindings =
        let modifier = config.wayland.windowManager.sway.config.modifier; in lib.mkOptionDefault {
          # Screenshots:
          # Super+P: Current window
          # Super+Shift+p: Select area
          # Super+Alt+p Current output
          # Super+Ctrl+p Select a window

          "${modifier}+p" = "exec grimshot save active";
          "${modifier}+Shift+p" = "exec grimshot save area";
          "${modifier}+Mod1+p" = "exec grimshot save output";
          "${modifier}+Ctrl+p" = "exec grimshot save window";
        };
    };
  };
}
