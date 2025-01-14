{
  config,
  lib,
  pkgs,
  ...
}: let
  plugins = with pkgs.vimPlugins; [
    # LazyVim
    LazyVim
    blink-cmp
    blink-emoji-nvim
    bufferline-nvim
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
    todo-comments-nvim
    tokyonight-nvim
    trouble-nvim
    typescript-tools-nvim
    vim-illuminate
    vim-kitty-navigator
    vim-startuptime
    which-key-nvim
    {
      name = "catppuccin";
      path = catppuccin-nvim;
    }
    {
      name = "mini.ai";
      path = mini-nvim;
    }
    {
      name = "mini.bufremove";
      path = mini-nvim;
    }
    {
      name = "mini.comment";
      path = mini-nvim;
    }
    {
      name = "mini.indentscope";
      path = mini-nvim;
    }
    {
      name = "mini.pairs";
      path = mini-nvim;
    }
    {
      name = "mini.surround";
      path = mini-nvim;
    }
    {
      name = "mini.files";
      path = mini-nvim;
    }
  ];
  mkEntryFromDrv = drv:
    if lib.isDerivation drv
    then {
      name = "${lib.getName drv}";
      path = drv;
    }
    else drv;
  lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
  parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };
in {
  # Install neovim and LazyVim base dependencies locally
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      extraPackages = with pkgs; [
        lua-language-server
        stylua
        nodePackages.typescript-language-server
        nodePackages.bash-language-server
        nixpkgs-fmt
        eslint_d
        prettierd
        lua-language-server
        statix
        vtsls
        lazygit
        ripgrep
        lazygit
        selene
        nil
        alejandra
        nvimpager
      ];

      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];
    };

    lazygit = {
      enable = true;
      settings = {
        git.paging = {
          colorArg = "always";
          pager = "${pkgs.delta}/bin/delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
        };
      };
    };
  };

  xdg.configFile = {
    # Create neovim init.lua and reference local plugins location
    "nvim/init.lua".text = ''
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        -- bootstrap lazy.nvim
        -- stylua: ignore
        vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
      end
      vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

      require("lazy").setup({
        defaults = {
          -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
          -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
          lazy = true,
          -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
          -- have outdated releases, which may break your Neovim install.
          version = false, -- always use the latest git commit
          -- version = "*", -- try installing the latest stable version for plugins that support semver
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
          { import = "lazyvim.plugins.extras.lang.python" },
          { import = "lazyvim.plugins.extras.linting.eslint" },
          { import = "lazyvim.plugins.extras.formatting.prettier" },
          { import = "lazyvim.plugins.extras.lang.markdown" },
          { import = "lazyvim.plugins.extras.lang.docker" },
          { import = "lazyvim.plugins.extras.lang.terraform" },
          { import = "lazyvim.plugins.extras.util.dot" },
          { import = "lazyvim.plugins.extras.coding.mini-surround" },
          { import = "lazyvim.plugins.extras.editor.mini-files" },
          { import = "lazyvim.plugins.extras.ui.mini-animate" },
          { import = "lazyvim.plugins.extras.editor.leap" },
          { import = "lazyvim.plugins.extras.util.octo" },
          { import = "lazyvim.plugins.extras.test.core" },
          { import = "lazyvim.plugins.extras.dap.core" },
          -- The following configs are needed for fixing lazyvim on nix
          -- disable mason.nvim, use programs.neovim.extraPackages
          { "williamboman/mason-lspconfig.nvim", enabled = false },
          { "williamboman/mason.nvim", enabled = false },
          -- import/override with your plugins
          { import = "plugins" },
          -- treesitter handled by "nvim/parser", put this line at the end of spec to clear ensure_installed
          { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
        },
        checker = { enabled = false }, -- automatically check for plugin updates
        performance = {
          rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
              "gzip",
              -- "matchit",
              -- "matchparen",
              -- "netrwPlugin",
              "tarPlugin",
              "tohtml",
              -- "tutor",
              "zipPlugin",
            },
          },
        },
      })
    '';

    # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
    "nvim/parser".source = "${parsers}/parser";

    # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
    "nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/dotfiles/dot_config/nvim/lua";
  };

  # Sets nvim to be used as the default pager (default=less)
  home.sessionVariables.PAGER = "${pkgs.nvimpager}/bin/nvimpager";
}
