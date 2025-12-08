# Dotfiles

## インストールが必須なもの

- ZInit
- Volta

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

5. tmuxを開き`prefix`+`I`でプラグインをインストール

