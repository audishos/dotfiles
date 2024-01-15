{ config, lib, pkgs, nixvim, neovimConfig, ... }:
{
  # imports = [
  # ./sway.nix
  # ./hyprland.nix
  # ];

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

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  # home-manager = {
  # useUserPackages = true;
  # useGlobalPkgs = true;

  # users.audisho = { pkgs, ... }: {
  # programs.home-manager.enable = true;

  # imports = [
  # 	nixvim
  # ];

  home = {
    stateVersion = "23.11";
    username = "audisho";
    homeDirectory = "/home/audisho";
    packages = with pkgs; [
      httpie
      bat
      micro
      neofetch
      nextcloud-client
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

      # Sway
      swaylock
      swayidle
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
      wezterm
    ];


    # Treesitter is configured as a locally developed module in lazy.nvim
    # we hardcode a symlink here so that we can refer to it in our lazy config
    # file."./.local/share/nvim/nix/nvim-treesitter/" = {
    #   source = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
    #   recursive = true;
    # };

    # activation = {
    #   myActivationAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #   	mkdir -p ${config.xdg.configHome}/nvim
    #     cp -r ${neovimConfig}/* ${config.xdg.configHome}/nvim
    #   '';
    # };
  };

  # programs.nixvim = {
  # 	enable = true;
  # };

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

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen256color";
    shell = "/etc/profiles/per-user/audisho/bin/zsh";
  };

  #       programs.neovim = {
  #         enable = true;
  #         # package = pkgs.neovim-nightly;
  #         vimAlias = true;
  # 
  #         plugins = [
  #           pkgs.vimPlugins.nvim-treesitter.withAllGrammars
  #         ];
  #       };

  programs.neovim = {
    enable = true;
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
        lualine-nvim
        neo-tree-nvim
        neoconf-nvim
        neodev-nvim
        noice-nvim
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
        persistence-nvim
        plenary-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        todo-comments-nvim
        tokyonight-nvim
        trouble-nvim
        vim-illuminate
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

  # file."${config.xdg.configHome}/nvim/" = {
  #   source = neovimConfig;
  #   recursive = true;	
  # };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      dracula-theme.theme-dracula
    ];
  };


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
      output."*" = { adaptive_sync = "on"; };
    };
  };
  # };
  # };
}
