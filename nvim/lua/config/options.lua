local opt = vim.opt

-- 行番号の表示
opt.number = true
opt.relativenumber = true

-- タブとインデントの設定
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

-- 折り返し設定
opt.wrap = false

-- OSのクリップボードと連携
opt.clipboard = "unnamedplus"
