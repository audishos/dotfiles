-- https://github.com/pwntester/octo.nvim
-- GitHub issues & PR integrations
return {
  {
    "pwntester/octo.nvim",
    lazy = false,
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR 'ibhagwan/fzf-lua',
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({ suppress_missing_scope = {
        projects_v2 = true,
      } })
    end,
  },
}
