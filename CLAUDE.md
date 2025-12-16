# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

## リポジトリ概要

Neovim、tmux、zsh、開発ツールの設定を管理する個人用dotfilesリポジトリ。

## アーキテクチャ

### Neovim設定 (nvim/)

Neovim 0.11以降の**新しいLSP API** (`vim.lsp.config()`と`vim.lsp.enable()`)を使用。設定は関心事の分離パターンに従っています：

- **lua/config/** - コア設定ロジック
  - `lsp.lua` - **すべてのLSP関連設定**（サーバー設定、キーマップ、autocmd）
  - `lazy.lua` - プラグインマネージャーのブートストラップ
  - `keymaps.lua` - グローバルキーマップ
  - `options.lua` - Vimオプション

- **lua/plugins/** - プラグイン定義のみ（lazy.nvim spec）
  - 各ファイルはlazy.nvimのプラグイン定義を返す
  - **設定ロジックはここに含めない** - `config/`に配置すること

**重要**: LSPサーバーを追加・変更する際は：
1. `lua/config/lsp.lua`に`vim.lsp.config()`を使ってサーバー設定を追加
2. `vim.lsp.enable({})`リストでサーバーを有効化
3. `lua/plugins/nvim-lspconfig.lua`にLSP設定を**入れない**こと

現在設定済みのLSPサーバー：
- `lua_ls` - Lua（vimグローバル対応）
- `vtsls` - TypeScript/JavaScript（型チェック、保存時にimport整理）
- `biome` - JavaScript/TypeScript（Biomeプロジェクト用リント＋フォーマット）
- `eslint` - JavaScript/TypeScript（ESLint+Prettier構成用リント）

フォーマット：
- `conform.nvim` - プロジェクトに応じて自動切り替え
  - Biomeプロジェクト（biome.json有）: Biomeでフォーマット
  - ESLint+Prettierプロジェクト: Prettierでフォーマット

### シェル設定

- **mise** - ツールバージョン管理（nvmやHomebrewからの移行中）
  - `.zshrc`で`eval "$(mise activate zsh)"`により有効化
  - 管理対象：Node.js、LSPサーバー、言語ランタイム

- **Zinit** - Zshプラグインマネージャー
  - シンタックスハイライト、オートサジェスト、補完
  - Pureテーマ

### Tmux設定 (tmux/)

- Prefix: `Ctrl-a`（デフォルトの`Ctrl-b`ではない）
- Vimスタイルのペインナビゲーション（`Ctrl-a h/j/k/l`）
- Vimキーバインドのコピーモード：
  - `v` - ビジュアル選択開始
  - `y` - **macOSクリップボード**にヤンク（`pbcopy`経由）
- プラグインマネージャー：TPM (Tmux Plugin Manager)
  - プラグインインストール：`Prefix + I`
  - プラグイン更新：`Prefix + U`

## セットアップ

初期セットアップには`~/dotfiles`から適切な場所へのシンボリックリンクが必要：

```bash
# ~/dotfilesにクローン
git clone https://github.com/rom6621/dotfiles.git ~/dotfiles

# シンボリックリンク作成
ln -s ~/dotfiles/.zshrc ~
ln -s ~/dotfiles/nvim ~/.config
ln -s ~/dotfiles/tmux ~/.config
```

### プラグインインストール

**Neovim**: 初回起動時にlazy.nvimが自動インストール

**Tmux**: tmuxを開いて`Prefix + I`を押してTPMプラグインをインストール

## 開発ワークフロー

### 新しい言語のLSPサポート追加

1. miseまたはnpm/homebrewでLSPサーバーをインストール
2. `nvim/lua/config/lsp.lua`に設定を追加：
   ```lua
   vim.lsp.config('server_name', {
     cmd = { 'server-command' },
     filetypes = { 'filetype' },
     root_markers = { 'marker-file', '.git' },
   })
   ```
3. enableリストに追加：`vim.lsp.enable({ 'lua_ls', 'vtsls', 'server_name' })`

### Neovimプラグイン追加

1. `nvim/lua/plugins/plugin-name.lua`に新規ファイル作成
2. lazy.nvim specを返す：
   ```lua
   return {
     "author/plugin",
     lazy = false,
   }
   ```
3. 複雑な設定ロジックは`nvim/lua/config/`に配置

### Tmux設定のリロード

`tmux/tmux.conf`編集後：`Prefix + r`（または`Ctrl-a r`）

## 主要な規約

- **Neovim leaderキー**: `Space`
- **Neovim local leader**: `\`
- **Tmux prefix**: `Ctrl-a`
- **LSPキーマップ**（`config/lsp.lua`で定義）：
  - `gd` - 定義ジャンプ
  - `<leader>k` - ホバードキュメント
  - `<leader>ca` - コードアクション
  - `<leader>rn` - リネーム
  - `]d` / `[d` - 次/前の診断
  - `<leader>e` - 診断フロート表示
  - `<leader>q` - 診断ロケーションリスト

## タスク管理

**重要**: このリポジトリではTODOを`README.md`のTODOセクションで管理します。

- 新しいタスクが発生したら、README.mdのTODOセクションにチェックリスト形式で追加
- タスク完了時は該当行を削除（完了履歴は残さない）
- TODOは具体的かつ実行可能な単位で記述

例：
```markdown
## TODO

- [ ] Terraform LSPの設定を追加
- [ ] 不要なHomebrewパッケージの整理
```
