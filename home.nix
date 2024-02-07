{ config, lib, pkgs, ... }:
{
  imports = [
    ./home/calibre.nix
    ./home/waybar.nix
    ./home/wezterm.nix
    ./home/neovim.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "audisho";
  # home.homeDirectory = "/home/audisho";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "23.11";

  home = {
    stateVersion = "23.11";
    username = "audisho";
    homeDirectory = "/home/audisho";
    packages = with pkgs; [
      httpie
      bat
      micro
      neofetch
      keepassxc
      android-tools
      betterdiscord-installer
      betterdiscordctl
      nodejs
      nodePackages_latest.pnpm
      fnm
      discord
      steam-tui
      steamcmd
      audacity
      gnome.nautilus
      spotify
      gnome.cheese
      fd
      rust-analyzer-unwrapped
      unzip
      zig
      firefox
      # fira-code-nerdfont not sure if this is needed due to system fonts config
      r2modman

      # Sway
      wl-clipboard
      mako
      alacritty
      pavucontrol
      xdg-utils
      glib
      dracula-theme
      gnome3.adwaita-icon-theme
      grim
      slurp
      wdisplays
      zip
      binutils
      ruff-lsp
      nodePackages.pyright
      openssl
      python3
      udisks
      sway-contrib.grimshot # sway screenshot tool
      pinta # simple image editor
      kitty
    ];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "audishos";
    userEmail = "audisho.sada@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableVteIntegration = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fnm"
      ];
      theme = "robbyrussell";
    };
    initExtra =
      ''
        eval "$(fnm env --use-on-cd)"
      '';
  };

  programs.hyfetch.enable = true;

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen256color";
    shell = "/etc/profiles/per-user/audisho/bin/zsh";
  };

  # Ensures nextcloud-client system tray is "mounted"
  systemd.user.services.nextcloud-client = {
    Service.ExecStartPre = lib.mkForce "${pkgs.coreutils}/bin/sleep 5";
    Unit = {
      After = lib.mkForce [ "graphical-session.target" ];
      PartOf = lib.mkForce [ ];
    };
  };

  services.nextcloud-client.enable = true;

  # programs.rofi.enable = true;
  programs.wofi.enable = true;


  wayland.windowManager.sway = {
    enable = true;

    config = rec {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "wofi --show run --allow-images";
      bars = [{
        command = "waybar";
      }];
      gaps = {
        inner = 8;
        smartBorders = "on";
        smartGaps = true;
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
