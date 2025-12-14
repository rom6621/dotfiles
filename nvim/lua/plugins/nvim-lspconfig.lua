return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    -- Lua LSP
    vim.lsp.config('lua_ls', {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', 'stylua.toml', 'selene.toml', '.git' },
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    -- TypeScript LSP (vtsls)
    vim.lsp.config('vtsls', {
      cmd = { 'vtsls', '--stdio' },
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
    })

    -- LSPを有効化
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('vtsls')
  end,
}
