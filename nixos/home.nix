{ pkgs, ... }:
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
    ./home/electron-apps.nix
    ./home/spotify.nix
    ./home/qt.nix
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
      keepassxc
      android-tools
      nodejs
      nodePackages_latest.pnpm
      fnm
      steam-tui
      steamcmd
      mono
      audacity
      nautilus
      libsForQt5.dolphin
      cheese
      fd
      rust-analyzer-unwrapped
      unzip
      zig
      firefox
      r2modman
      bubblewrap
      fuse-overlayfs
      dwarfs
      wl-clipboard
      mako
      alacritty
      pavucontrol
      xdg-utils
      glib
      dracula-theme
      adwaita-icon-theme
      grim
      slurp
      wdisplays
      zip
      binutils
      ruff-lsp
      openssl
      python3
      udisks
      sway-contrib.grimshot # sway screenshot tool
      pinta # simple image editor
      deluge-gtk
      streamlink
      streamlink-twitch-gui-bin
      qpdfview
      libreoffice-fresh
      htop
      btop
      telegram-desktop
    ];
  };

  programs = {
    bash.enable = true;
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
