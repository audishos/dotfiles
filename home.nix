{ config, lib, pkgs, ... }:
{
  imports = [
    ./home/sway.nix
    ./home/calibre.nix
    ./home/waybar.nix
    ./home/kitty.nix
    ./home/wezterm.nix
    ./home/neovim.nix
    ./home/wofi.nix
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
}
