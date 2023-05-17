#!/bin/bash

# 未定義な変数があったら途中で終了する
set -u

# shファイルが実行されたディレクトリ
BASEDIR=$(dirname $0)

# dotfilesディレクトリに移動する
cd $BASEDIR

# dotfilesディレクトリにある、ドットから始まり2文字以上の名前のファイルに対して
for file in .??*; do
	# 以下のファイル名に当てはまる場合は何もしない
	[ "$file" = ".git" ] && continue
	[ "$file" = ".gitconfig.local.template" ] && continue
	[ "$file" = ".gitmodules" ] && continue
	[ "$file" = ".gitignore" ] && continue

	# 上記以外ののファイルがあれば、シンボリックリンクを貼る
	ln -snfv ${PWD}/"$file" ~/
done
