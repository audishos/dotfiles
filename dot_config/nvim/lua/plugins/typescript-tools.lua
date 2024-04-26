return {
  {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_plugins = {
          -- for TypeScript v4.9+
          "@styled/typescript-styled-plugin",
          -- or for older TypeScript versions
          -- "typescript-styled-plugin",
        },
      },
    },
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   opts = {
  --     handlers = {
  --       function(server_name)
  --         if server_name == "tsserver" then
  --           return
  --         end
  --       end,
  --     },
  --   },
  -- },
}
