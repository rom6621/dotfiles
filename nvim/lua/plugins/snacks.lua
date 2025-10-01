return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Explorer（ファイラー）
      explorer = {
        hidden = true, -- ドットファイルを常に表示
        ignored = true, -- .gitignore で無視されるものも表示（必要なら）
        -- include / exclude で絞り込みも可能
        -- include = {}, exclude = {},
      },
      -- Picker（ファイル検索）
      picker = {
        hidden = true,
        ignored = true,
      },
    },
  },
}
