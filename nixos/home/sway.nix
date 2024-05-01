{ config, lib, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;

    # Required because bg file check fails 😢
    checkConfig = false;

    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "wofi --show run,drun --allow-images";
      bars = [{
        command = "waybar";
      }];
      defaultWorkspace = "workspace number 1";
      gaps = {
        inner = 8;
        smartBorders = "on";
      };
      window = {
        titlebar = false;
      };
      output."*" = {
        adaptive_sync = "on";
        bg = "${config.home.homeDirectory}/Pictures/wallpaper/aizhai_bridge-2.jpg fill";
      };
      startup = [
        { command = "${pkgs.coreutils}/bin/sleep 5 && ${pkgs.keepassxc}/bin/keepassxc"; }
      ];
      input = {
        "*" = {
          repeat_delay = "200";
          repeat_rate = "30";
        };
      };
      keybindings =
        let inherit (config.wayland.windowManager.sway.config) modifier; in lib.mkOptionDefault {
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
      floating = {
        criteria = [
          {
            app_id = "org.keepassxc.KeePassXC";
          }
          {
            app_id = "com.nextcloud.desktopclient.nextcloud";
          }
          {
            app_id = "pavucontrol";
          }
        ];
        # this floating titlebar option doesn't work
        # it seems that the window.titlebar option overrides it
        titlebar = true;
      };
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "808080";
      font-size = 24;
      indicator-idle-visible = true;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
      image = "/home/audisho/Pictures/wallpaper/swirly-blue.png";
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      # Lock before suspend
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
    ];
    timeouts = [
      # Lock after 5 minutes
      { timeout = 60 * 5; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
      # Turn off displays after 10 minutes & turn on when activity resumes
      { timeout = 60 * 10; command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\""; resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\""; }
      # Suspend after 20 minutes
      { timeout = 60 * 20; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };
}
