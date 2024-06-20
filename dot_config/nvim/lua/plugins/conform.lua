if true then
  -- disabled in favor of LazyVim extra for now
  return {}
end

return {
  {
    "stevearc/conform.nvim",
    enabled = true,
    opts = {
      formatters_by_ft = {
        javascript = { { "prettier" } },
        javascriptreact = { { "prettier" } },
        typescript = { { "prettier" } },
        typescriptreact = { { "prettier" } },
        vue = { { "prettier" } },
        css = { { "prettier" } },
        scss = { { "prettier" } },
        less = { { "prettier" } },
        html = { { "prettier" } },
        json = { { "prettier" } },
        jsonc = { { "prettier" } },
        yaml = { { "prettier" } },
        markdown = { { "prettier" } },
        ["markdown.mdx"] = { { "prettier" } },
        graphql = { { "prettier" } },
        handlebars = { { "prettier" } },
      },
    },
  },
}
