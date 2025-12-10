local keymap = vim.keymap

-- xを削除してヤンク（通常のdの動作）
keymap.set({ 'n', 'v' }, 'x', 'd', { noremap = true })

-- dを単純な削除（ヤンクしない、black hole registerを使用）
keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
