# Dotfiles

## TODO

- [ ] Terraform LSPの設定を追加

## インストールが必須なもの

- Zinit
- mise

## 初期化方法

1. リポジトリをクローン

```bash
cd ~ && git clone https://github.com/rom6621/dotfiles.git
cd dotfiles
```

2. インストールスクリプトを実行（Goが必要）

```bash
go run install.go
```

3. ターミナルを再起動または`source ~/.zshrc`を実行

4. tmuxを開き`Prefix + I`でプラグインをインストール
