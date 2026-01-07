# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

## リポジトリ概要

Neovim、tmux、zsh、開発ツールの設定を管理する個人用dotfilesリポジトリ。

## アーキテクチャ

### Neovim設定 (nvim/)

Neovim 0.11以降の**新しいLSP API** (`vim.lsp.config()`と`vim.lsp.enable()`)を使用。

**設計原則：関心事の分離**

- **lua/config/** - 設定ロジック（LSP、キーマップ、オプションなど）
- **lua/plugins/** - プラグイン定義のみ（lazy.nvim spec）
  - **設定ロジックをここに含めない** - 必ず`config/`に配置

**重要**: LSP関連の設定は**すべて** `lua/config/lsp.lua` に集約：
- サーバー設定（`vim.lsp.config()`）
- サーバー有効化（`vim.lsp.enable()`）
- キーマップ・autocmd
- `lua/plugins/nvim-lspconfig.lua`には**設定を入れない**

### シェル設定

- **mise** - ツールバージョン管理（`.zshrc`で有効化）
- **Zinit** - Zshプラグインマネージャー

### Tmux設定 (tmux/)

- Prefix: `Ctrl-a`（デフォルトの`Ctrl-b`から変更）
- macOSクリップボード統合（`pbcopy`）

### Ghostty設定 (ghostty/)

- `macos-option-as-alt = true` でtmuxのMetaキーバインドに対応

## セットアップ

シンボリックリンクで`~/.config`に配置：

```bash
ln -s ~/dotfiles/.zshrc ~
ln -s ~/dotfiles/nvim ~/.config
ln -s ~/dotfiles/tmux ~/.config
ln -s ~/dotfiles/ghostty ~/.config
```

## 開発ワークフロー

### 新しい言語のLSPサポート追加

1. LSPサーバーをインストール（mise/npm/homebrew）
2. `nvim/lua/config/lsp.lua`に設定を追加：
   ```lua
   vim.lsp.config('server_name', {
     cmd = { 'server-command' },
     filetypes = { 'filetype' },
     root_markers = { 'marker-file', '.git' },
   })
   ```
3. enableリストに追加：`vim.lsp.enable({ ..., 'server_name' })`

### Neovimプラグイン追加

1. `nvim/lua/plugins/plugin-name.lua`にlazy.nvim specを作成
2. 複雑な設定ロジックは`nvim/lua/config/`に配置

## タスク管理

**重要**: TODOは`README.md`のTODOセクションで管理。

- タスク発生時：チェックリスト形式で追加
- 完了時：該当行を削除（履歴は残さない）
- 具体的かつ実行可能な単位で記述
