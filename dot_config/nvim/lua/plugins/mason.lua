return {
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
}
