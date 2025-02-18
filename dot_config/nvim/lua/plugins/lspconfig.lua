local util = require("lspconfig.util")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          root_dir = util.root_pattern("node_modules", "package.json", "tsconfig.json", ".git"),
        },
        nil_ls = {},
        buf_ls = {},
      },
    },
  },
}
