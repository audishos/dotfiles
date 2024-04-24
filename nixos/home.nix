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
    ./home/nextcloud.nix
    ./home/git.nix
    ./home/zsh.nix
    ./home/obs.nix
    ./home/default-applications.nix
    # ./home/qt.nix
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
      # (discord.override {
      #   withVencord = true;
      # })
      webcord-vencord
      vesktop
      steam-tui
      steamcmd
      mono
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
      deluge-gtk
    ];
  };

  programs = {
    hyfetch.enable = true;

    # smart cd (remembers common paths)
    # https://github.com/ajeetdsouza/zoxide
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    # terminal file manager
    # https://github.com/jarun/nnn
    nnn = {
      enable = true;
    };

    gh.enable = true;
  };
}
