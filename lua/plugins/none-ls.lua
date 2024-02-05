return {
  {
    "nvimtools/none-ls.nvim",
    enabled = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- code actions
        nls.builtins.code_actions.statix,
        nls.builtins.code_actions.eslint_d,
        nls.builtins.code_actions.gitsigns,

        -- formatting
        nls.builtins.formatting.eslint_d,
        nls.builtins.formatting.markdownlint,
        nls.builtins.formatting.nixpkgs_fmt,
        nls.builtins.formatting.terraform_fmt,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.prettierd,

        -- diagnostics
        nls.builtins.diagnostics.terraform_validate,
        nls.builtins.diagnostics.eslint_d,
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.diagnostics.protolint,
        nls.builtins.diagnostics.statix,
        nls.builtins.diagnostics.selene,
      })
    end,
  },
}
