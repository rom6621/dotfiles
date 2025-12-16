# Dotfiles

## インストールが必須なもの

- Zinit
- mise

## 初期化方法

1. `$HOME/dotfiles`に本リポジトリを Clone する

```bash
cd ~/$HOME && git clone https://github.com/rom6621/dotfiles.git
```

2. `.zshrc`のシンボリックリンクを貼る

```bash
ln -s ~/dofiles/.zshrc ~
```

3. `nvim`のシンボリックリンクを貼る
```bash
ln -s ~/dotfiles/nvim ~/.config
```
4. `tmux`のシンボリックリンクを貼る
```bash
ln -s ~/dotfiles/tmux ~/.config
```

5. `mise`のシンボリックリンクを貼る
```bash
ln -s ~/dotfiles/mise ~/.config
```

6. miseでツールをインストール
```bash
mise install
```

7. tmuxを開き`prefix`+`I`でプラグインをインストール

## TODO

- [ ] lua-language-serverをmiseでインストール（現在GitHub rate limit）
- [ ] Terraform LSPの設定を追加
- [ ] mise管理ツールをCLAUDE.mdに反映
- [ ] 不要なHomebrewパッケージの整理

