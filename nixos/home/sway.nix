{
  config,
  lib,
  pkgs,
  ...
}: let
  grimshot = pkgs.sway-contrib.grimshot;
in {
  wayland.windowManager.sway = {
    enable = true;

    # Required because bg file check fails 😢
    checkConfig = false;

    config = rec {
      modifier = "Mod4";
      terminal = "${pkgs.kitty}/bin/kitty";
      # menu = "${pkgs.wofi}/bin/wofi --allow-images --show \"run,drun\"";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
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
        bg = "${config.home.homeDirectory}/Pictures/wallpaper/vietnam-street-night.jpg fill";
      };
      startup = [
        {command = "${pkgs.coreutils}/bin/sleep 5 && ${pkgs.keepassxc}/bin/keepassxc";}
      ];
      input = {
        "*" = {
          repeat_delay = "200";
          repeat_rate = "30";
        };
      };
      keybindings = lib.mkOptionDefault {
        # Screenshots:
        # Super+p: Current window
        # Super+Shift+p: Select area
        # Super+Alt+p Current output
        # Super+Ctrl+p Select a window
        "${modifier}+p" = "exec ${grimshot}/bin/grimshot save active";
        "${modifier}+Shift+p" = "exec ${grimshot}/bin/grimshot save area";
        "${modifier}+Mod1+p" = "exec ${grimshot}/bin/grimshot save output";
        "${modifier}+Ctrl+p" = "exec ${grimshot}/bin/grimshot save window";

        # Lock system
        "${modifier}+Ctrl+l" = "exec ${pkgs.swaylock}/bin/swaylock -fF";

        # Emoji picker
        # "${modifier}+colon" = "exec ${pkgs.wofi-emoji}/bin/wofi-emoji";
        "${modifier}+colon" = "exec ${pkgs.bemoji}/bin/bemoji -t";
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
      };
    };
  };

  home.packages = [grimshot];

  programs.swaylock = {
    enable = true;
    settings = {
      color = "808080";
      font-size = 24;
      indicator-idle-visible = true;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
      image = "${config.home.homeDirectory}/Pictures/wallpaper/wulingyuan_scenic_area_china.png";
      scaling = "fill";
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      # Lock before suspend
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      # Lock after 5 minutes
      {
        timeout = 60 * 5;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      # Turn off displays after 10 minutes & turn on when activity resumes
      {
        timeout = 60 * 10;
        command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\"";
      }
      # Suspend after 20 minutes
      {
        timeout = 60 * 20;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
