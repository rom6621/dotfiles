return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          -- .gitignoreされたファイルを隠しファイルとしてマーク（薄く表示）
          local dir = require("oil").get_current_dir(bufnr)
          if not dir then
            return false
          end

          -- git check-ignoreで確認
          local full_path = dir .. name
          local handle = io.popen("git -C " .. vim.fn.shellescape(dir) .. " check-ignore " .. vim.fn.shellescape(full_path) .. " 2>/dev/null")
          if handle then
            local result = handle:read("*a")
            handle:close()
            if result ~= "" then
              return true
            end
          end

          return false
        end,
      },
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
