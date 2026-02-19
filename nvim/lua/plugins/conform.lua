return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "biome", "prettier" },
        javascriptreact = { "biome", "prettier" },
        typescript = { "biome", "prettier" },
        typescriptreact = { "biome", "prettier" },
        json = { "biome", "prettier" },
        jsonc = { "biome", "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        go = {},  -- LSP (gopls) にフォーマットを任せる
        swift = { "swift_format" },
      },
      format_on_save = function(bufnr)
        local filetype = vim.bo[bufnr].filetype

        -- GoファイルはLSP (gopls) にフォーマットを任せる
        if filetype == "go" then
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end

        -- JavaScript/TypeScript等: Biome/Prettierを使用
        -- プロジェクトルートでbiome.json/biome.jsoncを探す
        local root = vim.fs.root(bufnr, { 'biome.json', 'biome.jsonc', 'package.json', '.git' })
        local has_biome = false

        if root then
          has_biome = vim.fn.filereadable(root .. '/biome.json') == 1 or
                      vim.fn.filereadable(root .. '/biome.jsonc') == 1
        end

        -- Biome設定があればBiomeのみ、なければPrettierのみ
        local formatters = { "prettier" }
        if has_biome then
          formatters = { "biome" }
        end

        return {
          timeout_ms = 500,
          lsp_fallback = true,
          formatters = formatters,
        }
      end,
    })
  end,
}
