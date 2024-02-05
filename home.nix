{ config, lib, pkgs, neovimConfig, ... }:
{
  imports = [./home/calibre.nix];

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
      ripgrep
      fd
      lazygit
      lua-language-server
      rust-analyzer-unwrapped
      unzip
      zig
      firefox
      fira-code-nerdfont
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

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}

      config.color_scheme = 'Catppuccin Mocha (Gogh)'
      config.font = wezterm.font 'Fira Code'
      config.window_background_opacity = 0.8

      return config
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

  # Install neovim and LazyVim base dependencies locally
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      nodePackages.typescript-language-server
      nixpkgs-fmt
      # Telescope
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  # Create neovim init.lua and reference local plugins location
  xdg.configFile."nvim/init.lua".text =
    let
      plugins = with pkgs.vimPlugins; [
        # LazyVim
        LazyVim
        bufferline-nvim
        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        cmp_luasnip
        conform-nvim
        dashboard-nvim
        dressing-nvim
        flash-nvim
        friendly-snippets
        gitsigns-nvim
        indent-blankline-nvim
        leap-nvim
        lualine-nvim
        neo-tree-nvim
        neoconf-nvim
        neodev-nvim
        neotest
        neotest-jest
        noice-nvim
        none-ls-nvim
        nui-nvim
        nvim-cmp
        nvim-lint
        nvim-lspconfig
        nvim-notify
        nvim-spectre
        nvim-treesitter
        nvim-treesitter-context
        nvim-treesitter-textobjects
        nvim-ts-autotag
        nvim-ts-context-commentstring
        nvim-web-devicons
        octo-nvim
        persistence-nvim
        plenary-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        todo-comments-nvim
        tokyonight-nvim
        trouble-nvim
        vim-fugitive
        vim-illuminate
        vim-rhubarb
        vim-startuptime
        which-key-nvim
        { name = "LuaSnip"; path = luasnip; }
        { name = "catppuccin"; path = catppuccin-nvim; }
        { name = "mini.ai"; path = mini-nvim; }
        { name = "mini.bufremove"; path = mini-nvim; }
        { name = "mini.comment"; path = mini-nvim; }
        { name = "mini.indentscope"; path = mini-nvim; }
        { name = "mini.pairs"; path = mini-nvim; }
        { name = "mini.surround"; path = mini-nvim; }
      ];
      mkEntryFromDrv = drv:
        if lib.isDerivation drv then
          { name = "${lib.getName drv}"; path = drv; }
        else
          drv;
      lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    in
    ''
      require("lazy").setup({
        defaults = {
          lazy = true,
        },
        dev = {
          -- reuse files from pkgs.vimPlugins.*
          path = "${lazyPath}",
          patterns = { "." },
          -- fallback to download
          fallback = true,
        },
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          -- import any extras modules here
          { import = "lazyvim.plugins.extras.lang.typescript" },
          { import = "lazyvim.plugins.extras.lang.json" },
          -- { import = "lazyvim.plugins.extras.linting.eslint" },
          -- { import = "lazyvim.plugins.extras.formatting.prettier" },
          { import = "lazyvim.plugins.extras.util.dot" },
          { import = "lazyvim.plugins.extras.ui.mini-animate" },
          { import = "lazyvim.plugins.extras.lsp.none-ls" },
          { import = "lazyvim.plugins.extras.editor.leap" },
          { import = "lazyvim.plugins.extras.test.core" },
          -- The following configs are needed for fixing lazyvim on nix
          -- force enable telescope-fzf-native.nvim
          { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
          -- disable mason.nvim, use programs.neovim.extraPackages
          { "williamboman/mason-lspconfig.nvim", enabled = false },
          { "williamboman/mason.nvim", enabled = false },
          -- import/override with your plugins
          { import = "plugins" },
          -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
          { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
        },
      })
    '';

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = "${neovimConfig}/lua";

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

  programs.waybar = {
    enable = true;
  };

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
