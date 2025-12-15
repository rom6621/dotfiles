return {
  "prettier/vim-prettier",
  build = "npm install",
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "css", "scss", "html", "markdown" },
  config = function()
    -- 保存時に自動フォーマット
    vim.g["prettier#autoformat"] = 1
    vim.g["prettier#autoformat_require_pragma"] = 0

    -- Prettierの設定
    vim.g["prettier#config#semi"] = true
    vim.g["prettier#config#single_quote"] = true
    vim.g["prettier#config#trailing_comma"] = "all"
    vim.g["prettier#config#print_width"] = 80
    vim.g["prettier#config#tab_width"] = 2
  end,
}
