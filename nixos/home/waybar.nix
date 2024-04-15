{ catppuccinWaybar, ... }:
{
  programs.waybar = {
    enable = true;

    settings.mainBar = {
      "reload_style_on_change" = true;
      height = 30;
      spacing = 32;
      "modules-left" = [
        "sway/workspaces"
        "sway/mode"
        "sway/scratchpad"
        "custom/media"
      ];
      "modules-center" = [
        "sway/window"
        "privacy"
      ];
      "modules-right" = [
        "mpd"
        "idle_inhibitor"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "keyboard-state"
        "sway/language"
        "clock"
        "tray"
      ];
      "keyboard-state" = {
        numlock = true;
        capslock = true;
        format = "{name} {icon}";
        "format-icons" = {
          locked = "";
          unlocked = "";
        };
      };
      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };
      "sway/scratchpad" = {
        format = "{icon} {count}";
        "show-empty" = false;
        "format-icons" = [
          ""
          ""
        ];
        tooltip = true;
        "tooltip-format" = "{app}: {title}";
      };
      mpd = {
        format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
        "format-disconnected" = "Disconnected ";
        "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
        "unknown-tag" = "N/A";
        interval = 2;
        "consume-icons" = {
          on = "";
        };
        "random-icons" = {
          off = "<span color=\"#f53c3c\"></span> ";
          on = "";
        };
        "repeat-icons" = {
          on = "";
        };
        "single-icons" = {
          on = "1";
        };
        "state-icons" = {
          paused = "";
          playing = "";
        };
        "tooltip-format" = "MPD (connected)";
        "tooltip-format-disconnected" = "MPD (disconnected)";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        "format-icons" = {
          activated = "";
          deactivated = "";
        };
      };
      tray = {
        spacing = 10;
      };
      clock = {
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = "{:%Y-%m-%d}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = {
        format = "{}% ";
      };
      temperature = {
        "critical-threshold" = 80;
        format = "{temperatureC}°C {icon}";
        "format-icons" = [
          ""
          ""
          ""
        ];
      };
      backlight = {
        format = "{percent}% {icon}";
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
          ""
        ];
      };
      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        "format-charging" = "{capacity}% ";
        "format-plugged" = "{capacity}% ";
        "format-alt" = "{time} {icon}";
        "format-icons" = [
          ""
          ""
          ""
          ""
          ""
        ];
      };
      "battery#bat2" = {
        bat = "BAT2";
      };
      network = {
        "format-wifi" = "{essid} ({signalStrength}%) ";
        "format-ethernet" = "{ipaddr}/{cidr} ";
        "tooltip-format" = "{ifname} via {gwaddr} ";
        "format-linked" = "{ifname} (No IP) ";
        "format-disconnected" = "Disconnected ⚠";
        "format-alt" = "{ifname}: {ipaddr}/{cidr}";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        "format-bluetooth" = "{volume}% {icon} {format_source}";
        "format-bluetooth-muted" = " {icon} {format_source}";
        "format-muted" = " {format_source}";
        "format-source" = "{volume}% ";
        "format-source-muted" = "";
        "format-icons" = {
          headphone = "";
          "hands-free" = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            ""
          ];
        };
        "on-click" = "pavucontrol";
      };
      "custom/media" = {
        format = "{icon} {}";
        "return-type" = "json";
        "max-length" = 40;
        "format-icons" = {
          spotify = "";
          default = "🎜";
        };
        escape = true;
        exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
      };
    };

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
