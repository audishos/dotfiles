local util = require("lspconfig.util")

local get_eslint_root_in_monorepo = function(fname)
  return util.root_pattern("package.json", "tsconfig.json")(fname) or util.root_pattern(".git")(fname)
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          root_dir = get_eslint_root_in_monorepo,
        },
        nil_ls = {
          root_dir = util.root_pattern("flake.nix"),
        },
      },
    },
  },
}
