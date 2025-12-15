local keymap = vim.keymap

-- xを削除してヤンク（通常のdの動作）
keymap.set({ 'n', 'v' }, 'x', 'd', { noremap = true })

-- xxで行全体を削除してヤンク（ddと同じ動作）
keymap.set('n', 'xx', 'dd', { noremap = true })

-- dを単純な削除（ヤンクしない、black hole registerを使用）
keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })

-- ddで行全体を単純削除（ヤンクしない）
keymap.set('n', 'dd', '"_dd', { noremap = true })
