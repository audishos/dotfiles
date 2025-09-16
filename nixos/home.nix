{pkgs, ...}: {
  imports = [
    ./home/android.nix
    ./home/calibre.nix
    ./home/cursors.nix
    ./home/default-applications.nix
    ./home/fuzzel.nix
    ./home/gaming.nix
    ./home/git.nix
    ./home/kitty.nix
    ./home/mako.nix
    ./home/neovim.nix
    ./home/nextcloud.nix
    ./home/nnn.nix
    ./home/obs.nix
    ./home/qt.nix
    ./home/session-variables.nix
    ./home/spotify.nix
    ./home/sway.nix
    ./home/waybar.nix
    ./home/wezterm.nix
    ./home/wofi.nix
    ./home/yazi.nix
    ./home/zsh.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "audisho";
  # home.homeDirectory = "/home/audisho";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.

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
      mono
      audacity
      kdePackages.kalk
      pcmanfm
      cheese
      fd
      rust-analyzer-unwrapped
      unzip
      zig
      bubblewrap
      fuse-overlayfs
      dwarfs
      wl-clipboard
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
      ruff
      openssl
      python3
      udisks
      pinta # simple image editor
      gimp3-with-plugins
      deluge-gtk
      streamlink
      streamlink-twitch-gui-bin
      pdf4qt
      # Never ending build lol
      # libreoffice-fresh
      htop
      gotop
      telegram-desktop
      kotatogram-desktop
      p7zip
      sublime3
      ncpamixer # TUI alternative to pavucontrol
      inkscape
      vesktop
      r2modman
      bruno
      # removed - lack of maintenance 😢
      # logseq
      zoom-us
      dig # DNS lookup utility
      ollama-rocm
      netcat-gnu
      sshfs # Mount filesystems over SSH https://github.com/libfuse/sshfs
      bzip2
      bzip3
      gzip
      television # fast file search TUI https://github.com/alexpasmantier/television
      zk # plain text personal wiki https://github.com/zk-org/zk
      zenith # like htop with GPU https://github.com/bvaisvil/zenith
      ffmpeg
      playwright
      rsync
      exiftool
      jellyfin-media-player
      helvum # GTK patchbay for pipewire
      libarchive
      net-tools
    ];

    sessionVariables = {
      # https://zk-org.github.io/zk/notes/notebook.html
      ZK_NOTEBOOK_DIR = "~/Nextcloud/Notes/";
    };
  };

  services = {
    network-manager-applet.enable = true;

    # automatic day/night light/dark mode switcher
    darkman = {
      enable = true;

      settings = {
        lat = 43.6;
        lng = -79.3;
        dbusserver = true;
        portal = true;
      };
    };

    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config = {
      common = {
        default = "wlr";
        "org.freedesktop.impl.portal.Settings" = "darkman";
      };
    };
  };

  programs = {
    bash.enable = true;
    hyfetch.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-devedition.override {
        # See nixpkgs' firefox/wrapper.nix to check which options you can use
        nativeMessagingHosts = [
          # Tridactyl native connector
          pkgs.tridactyl-native
        ];
      };
    };

    # librewolf.enable = true;

    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };

    thunderbird = {
      enable = true;
      profiles = {};
    };

    # smart cd (remembers common paths)
    # https://github.com/ajeetdsouza/zoxide
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    gh.enable = true;

    yt-dlp.enable = true;

    freetube.enable = true;

    mpv.enable = true;

    nheko.enable = true;

    fish.enable = true;
  };
}
