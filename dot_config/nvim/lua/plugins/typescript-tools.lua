return {
  {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        -- "change"|"insert_leave" determine when the client asks the server about diagnostic
        publish_diagnostics_on = "change",
        -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
        -- "remove_unused_imports"|"organize_imports") -- or string "all"
        -- to include all supported code actions
        -- specify commands exposed as code_actions
        expose_as_code_action = "all",
        -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
        tsserver_plugins = {
          -- for TypeScript v4.9+
          "@styled/typescript-styled-plugin",
          -- or for older TypeScript versions
          -- "typescript-styled-plugin",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      handlers = {
        function(server_name)
          if server_name == "tsserver" then
            return
          end
        end,
      },
    },
  },
}
