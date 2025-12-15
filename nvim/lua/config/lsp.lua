-- LSPサーバーの設定
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
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifier = 'relative',
        quoteStyle = 'single',
      },
      updateImportsOnFileMove = {
        enabled = 'always',
      },
    },
    javascript = {
      preferences = {
        importModuleSpecifier = 'relative',
        quoteStyle = 'single',
      },
      updateImportsOnFileMove = {
        enabled = 'always',
      },
    },
  },
})

-- LSPを有効化
vim.lsp.enable({ 'lua_ls', 'vtsls' })

-- LSP Attach時の設定
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local buf = args.buf

    if client:supports_method("textDocument/definition") then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to definition" })
    end

    if client:supports_method("textDocument/hover") then
      vim.keymap.set("n", "<leader>k",
        function() vim.lsp.buf.hover({ border = "single" }) end,
        { buffer = buf, desc = "Show hover documentation" })
    end

    if client:supports_method("textDocument/codeAction") then
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
        { buffer = buf, desc = "Code action" })
    end

    if client:supports_method("textDocument/rename") then
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
        { buffer = buf, desc = "Rename symbol" })
    end

    -- Diagnostics (エラー・警告の表示)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,
      { buffer = buf, desc = "Show diagnostic" })
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist,
      { buffer = buf, desc = "Show diagnostic list" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
      { buffer = buf, desc = "Next diagnostic" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
      { buffer = buf, desc = "Previous diagnostic" })

    -- Organize imports on save for TypeScript/JavaScript
    if client.name == "vtsls" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("my.lsp.organize_imports", { clear = false }),
        buffer = buf,
        callback = function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
          }
          vim.lsp.buf.execute_command(params)
        end,
      })
    end

    -- Auto-format ("lint") on save.
    -- Usually not nedded if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    if client:supports_method("textDocument/inlineCompletion") then
      vim.lsp.inline_completion.enable(true, { bufnr = buf })
      vim.keymap.set("i", "<Tab>", function()
      end, {
        expr = true,
        buffer = buf,
        desc = "Accept the current inline completion",
      })
    end
  end,
})
