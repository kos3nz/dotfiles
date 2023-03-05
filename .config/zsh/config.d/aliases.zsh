### Aliases ###
alias his='history'
alias ...='cd ../..'
alias ....='cd ../../..'
alias e="emacs"
alias vi='vim'
alias v='nvim'
alias nv='nvim'
alias gu='gitui'
alias lg='lazygit'
alias so='source'
alias be='bundle exec'
alias ber='bundle exec ruby'
alias c="code"
alias c.='code .' # Vscodeを開く(usage: c <file | dir> でファイル(ディレクトリ)を開く)
alias cn='code -n' # Vscodeを新しいウィンドウで開く(usage: cn <file | dir>)
alias sz='source ~/.zshrc'
alias szsh='source ~/.zshrc'
alias port='lsof -i' # ポートのプロセスを調べる -> lsof -i :3000
alias portk='kill -9' # プロセスをkill (-9 = 強制終了) -> kill -9 [PIDの数字]
alias restart='sudo fdesetup authrestart'
alias delcache='sudo rm -rf /System/Library/Caches/* /Library/Caches/* ~/Library/Caches/*' # Macのキャッシュを削除
# sudo du -x -m -d 5 / | awk '$1 >= 1000{print}' # 1000MB以上のファイルを抽出
# sudo du -g -x -d 5 / | awk ‘$1 >= 5{print}’ # 5GB以上のファイルを抽出

# ls
if type "exa" > /dev/null 2>&1; then
    alias ls='exa'
    alias l='exa -F'
    alias la='exa -a'
    alias ll='exa -l'
fi

# cat
if type "bat" > /dev/null 2>&1; then
    alias cat="bat"
fi

# npm
# alias nin='npm init'
# alias niy='npm init -y'
# alias ni='npm install'
# alias nid='npm install --save-dev'
# alias nig='npm install -g'
# alias nr='npm run'
# alias ns='npm start'
# alias nt='npm test'
# alias nadt='npm audit'
# alias nadff='npm audit fix --force'
# alias nun='npm uninstall'
# alias nund='npm uninstall --save-dev'
# alias nrm='npm remove'
# alias nrmd='npm remove --save-dev'
# alias npmeslint='npm install prettier eslint eslint-config-prettier eslint-plugin-prettier eslint-config-airbnb eslint-plugin-node eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-react --save-dev'

# Yarn
alias niyg='npm install -g yarn'
alias ysvb='yarn set version berry' # 'Berry' is the codename or the Yarn 2 release line
alias yin='yarn init'
alias yi='yarn install' # Installing all the dependencies
alias ys='yarn start'
alias ya='yarn add' # Adding a dependency
alias yad='yarn add --dev' # Adding a dependency to different categories of dependencies
alias yap='yarn add --peer' # Adding a dependency to different categories of dependencies
alias yup='yarn upgrade' # Upgrading a dependency
alias yrm='yarn remove'
alias yadt='yarn audit'
alias ysvl='yarn set version latest' # Upgrading Yarn itself
alias ysvs='yarn set version from sources'
alias yag='yarn global add' # Install a package globally
alias yw='yarn workspace'

# Git && Github
alias g='git'
alias gin='git init'
alias gs='git status'
alias gb='git branch' # ブランチ作成 ($ git branch <branchName>)
alias gba='git branch -a' # ブランチの一覧を見る
alias gc='git checkout'
alias gcb='git checkout -b' # branchを作成してcheckout
alias gchm='git checkout main'
alias gchms='git checkout master'
alias gpuo='git push -u origin' # ブランチをリモートに登録 ($ git push -u origin <branchName>)
alias gct='git commit'
alias gg='git grep'
alias ga='git add'
alias gd='git diff'
alias gl='git log'
alias glg='git log --graph'
alias glgo='git log --graph --oneline'
alias graph='git log --all --decorate --oneline --graph'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gm='git merge'
alias gmod='git merge origin/develop'
alias gmud='git merge upstream/develop'
alias gmom='git merge origin/main'
alias gmoms='git merge origin/master'
alias gcm='git commit -m'
alias gcam='git commit -am' # add + commit & message
alias gcamm='git commit --amend -m' # 直前のコミットのメッセージを修正
alias gcane='git commit --amend --no-edit' # コードを修正した後、コミットメッセージを変更せずに最新のコミットに上書き
alias grbi='git rebase -i' # git rebase -i HEAD~3 で3つ前までのコミットのコメントを修正できる (pick -> edit に変更して保存。git commit --amend -m でもう一度コメントを書き直し、git rebase --continue で最新のコミットに戻る。(editするコミットが2つ以上ある場合は、次のeditするコミットに移る))
alias grbc='git rebase --continue'
alias grset='git reset --soft HEAD\^' # 直前のコミットを取り消し (--soft: コミット取り消し&ワークディレクトリはそのまま)
alias grseth='git reset --hard HEAD\^' # (--hard : コミット取り消し&ワークディレクトリの内容書き換え, HEAD^: 直前のコミット) HEAD^^^とHEAD~3とHEAD~~~とHEAD~{3}と@^^^は同じ意味
alias gpo='git push origin'
alias gpom='git push origin main'
alias gpoms='git push origin master'
alias gpoh='git push origin HEAD' # branch名を書かずともbranchにpushできる
alias gploh='git pull origin HEAD' # branch名を書かずともbranchにpushできる
alias gst='git stash'
alias gsl='git stash list'
alias gsu='git stash -u'
alias gsp='git stash pop'
alias ggpull='git pull origin $(current_branch)' # 現在いるbranchをoriginからpull
alias ggpush='git push origin $(current_branch)' # originに今いるbranchをpush
alias gibonv='gibo dump Node VisualStudioCode >> .gitignore' # .gitignoreにテンプレートを上書き
alias gres='git restore'
alias gr='git remote' # check remote branches
alias grrm='git remote remove' # remove remote branch
alias gra='git remote add'
alias grao='git remote add origin' # grao (remote repo) でリモートリポジトリ追加
alias grsurlo='git remote set-url origin' # git remote set-url origin {new url} リモートURL変更
alias grmrc='git rm -r --cached .' # ファイル全体キャッシュ削除

# Heroku
alias hepush='git push heroku master'
alias heli='heroku login'
alias hecr='heroku create'
alias heo='heroku open'
alias helog='heroku logs --tail'
alias hecf='heroku config' # 環境変数一覧を表示
alias hecs='heroku config:set' # set enviromental variables ( 'heroku config:set NODE_ENV=production' )
alias hern='heroku apps:rename'
alias heps='heroku ps' # taking a look at all dynos
alias hers='heroku ps:restart' # restart the server
alias helo='heroku local' # アプリケーションをlocalで実行
alias herb='heroku run bash'
alias heao='heroku addons' # アドオン一覧を確認
alias heap='heroku apps' # アプリ一覧を確認
alias heps='heroku ps' # プロセス確認
alias hes='heroku status' # アプリの状態確認

# DataBase
alias bslist='brew services list'
alias bunlink='brew unlink' # brew unlink postgresql
alias blink='brew link' # brew link postgresql@9.6

# Postgresql
alias startpsql='brew services start postgresql'
alias stoppsql='brew services stop postgresql'

# alias pg='pgcli -h localhost -p 5432'
alias pg='psql'

# Radis
alias startredis='brew services start redis'
alias stopredis='brew services stop redis'
alias rsv='redis-server'
alias rcli='redis-cli'

# MongoDB
alias startmongo='brew services start mongodb-community'
alias stopmongo='brew services stop mongodb-community'
alias mongoatlas='mongo "mongodb+srv://cluster0.umymv.mongodb.net/myFirstDatabase" --username kos' # atlas に接続

# Docker
alias d='docker'
alias dc='docker-compose'
alias dc_build_up='docker-compose rm -fv && docker-compose build && docker-compose up'
alias rm_docker_images='docker images -qf dangling=true | xargs docker rmi'
alias rm_docker_containers='docker ps -aqf status=exited | xargs docker rm -v' # rm with volumes
alias rm_docker_volumes='docker volume ls -qf dangling=true | xargs docker volume rm'
alias rm_docker_compose_containers='docker-compose rm -fv'
alias dsyspru='docker system prune'

# Kubernetes
alias k='kubectl'

# fzf
alias pccd='cd "$(find . -type d | fzf)"' # ディレクトリ名でしぼってcd
alias pcgco='git branch --sort=-authordate | cut -b 3- | perl -pe '\''s#^remotes/origin/###'\'' | perl -nlE '\''say if !$c{$_}++'\'' | grep -v -- "->" | fzf | xargs git checkout' # ブランチ名で絞ってgit checkout
alias pcgbd='git br | fzf | xargs git br -d' # ブランチ名で絞ってgit branch -d
alias pcgrb='git br | fzf | xargs git rebase' # ブランチ名で絞ってgit rebase

# ghq
alias gq='ghq get' # リポジトリをghq管理下へ取得
alias gqls='ghq list' # ghq管理下のリポジトリ一覧
alias gqud='ghq list | ghq get --update --parallel' #手元の管理リポジトリを一括で最新の状態に更新
alias gqtx='ghq list > repolist.txt' # ghq管理下のリポジトリ一覧をテキストファイルに保存
alias gqtx_local='ghq get --update --parallel < repolist.txt' # ghq管理下のリポジトリ一覧をテキストファイルから一括で最新の状態に更新(別マシンへのリポジトリ移行時に使用)
alias gqroot='git config --global ghq.root' # ghqのrootディレクトリをgit configで設定
alias gqmv='GHQ_MIGRATOR_ACTUALLY_RUN=1 ./ghq-migrator.bash' # ghq管理下へローカルリポジトリを移動(ghq-migratorディレクトリへ移動したあと、'gqmv ~/foo'でfooリポジトリをghq管理下へ移動)

# Tmux
alias tm='tmux'
alias tn='tmux new-session -A -s $(basename "`pwd`")' # カレントディレクトリ名でセッション作成

# ディレクトリ管理
alias cleancdr='bash ~/shell-scripts/clean-no-exists-directories.sh > ~/shell-scripts/.chpwd-recent-dirs-clean && mv ~/shell-scripts/.chpwd-recent-dirs-clean ~/.chpwd-recent-dirs' # 存在しないディレクトリを .chpwd-recent-dir から削除
