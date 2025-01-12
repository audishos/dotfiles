return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      ---@type table<string, snacks.win.Config>
      styles = {
        ---@diagnostic disable-next-line: missing-fields
        notification = {
          wo = {
            wrap = true,
          },
        },
      },
    },
  },
}
