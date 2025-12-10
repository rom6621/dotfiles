local lsp_names = {
  'lua_ls',
}

--
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

-- LuaのLSPを読み込み
vim.lsp.enable(lsp_names)
