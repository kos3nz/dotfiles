# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-open web-search zsh-autosuggestions fast-syntax-highlighting)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

### History
HISTFILE=~/.zsh_history      # ヒストリファイルを指定
HISTSIZE=10000               # ヒストリに保存するコマンド数
SAVEHIST=10000               # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録

### Aliases
alias delcache='sudo rm -rf /System/Library/Caches/* /Library/Caches/* ~/Library/Caches/*' # Macのキャッシュを削除
# sudo du -x -m -d 5 / | awk '$1 >= 1000{print}' # 1000MB以上のファイルを抽出
# sudo du -g -x -d 5 / | awk ‘$1 >= 5{print}’ # 5GB以上のファイルを抽出
alias his='history'
alias ...='cd ../..'
alias ....='cd ../../..'
alias e="emacs"
alias v='vim'
alias vi='vim'
alias nv='nvim'
alias tm='tmux'
alias gu='gitui'
alias lg='lazygit'
alias so='source'
alias be='bundle exec'
alias ber='bundle exec ruby'
alias c.='code .' # Vscodeを開く(usage: c <file | dir> でファイル(ディレクトリ)を開く)
alias cn='code -n' # Vscodeを新しいウィンドウで開く(usage: cn <file | dir>)
alias c.="code ."
alias czsh='code ~/.zshrc'
alias szsh='source ~/.zshrc'
alias cgconfig='code ~/.gitconfig'
alias al='alias'
alias port='lsof -i' # ポートのプロセスを調べる -> lsof -i :3000
alias portk='kill -9' # プロセスをkill (-9 = 強制終了) -> kill -9 [PIDの数字]
alias restart='sudo fdesetup authrestart'
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
# ディレクトリ管理
alias cleancdr='bash ~/shell-scripts/clean-no-exists-directories.sh > ~/shell-scripts/.chpwd-recent-dirs-clean && mv ~/shell-scripts/.chpwd-recent-dirs-clean ~/.chpwd-recent-dirs' # 存在しないディレクトリを .chpwd-recent-dir から削除
# cp コマンドでカレントディレクトリ以下のディレクトリを絞り込んだ後に移動する
function find_cd() {
    cd "$(find . -type d | fzf --reverse)"
}
alias fd="find_cd"
# fe コマンドでカレントディレクトリ以下のファイルを絞り込んだ後に bat で開く
function find_and_bat() {
    bat "$(find . -type f | fzf --reverse)"
}
alias fb="find_and_bat"
# pk で実行中のプロセスを選択して kill
function fzf-pkill() {
  for pid in `ps aux | fzf | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="fzf-pkill"

# ⌃r = fzf で history 検索
function fzf-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | fzf --reverse`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

# ^o = fzf で過去移動したディレクトリに移動
# setting for cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
fi
# search a destination from cdr list
function fzf-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  fzf --reverse
}
# search a destination from cdr list and cd the destination
function fzf-cdr() {
  local destination="$(fzf-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N fzf-cdr
bindkey '^O' fzf-cdr

# ghqとの連携。ghqの管理化にあるリポジトリを一覧表示する。ctrl - ]にバインド。
function fzf-src () {
  local selected_dir=$(ghq list -p | fzf --reverse)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

# === fzf + ripgrep ===
fzgrep() {
  INITIAL_QUERY=""
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --phony --query "$INITIAL_QUERY" \
        --preview 'bat `echo {} | cut -f 1 --delim ":"`'
}

# 環境変数PGDATAの設定
export PGDATA=/usr/local/var/postgres
# pgcli 結界の折り返しを有効にする
export LESS="-SRXF"
# pgcli 結果の折り返しを無効にする
# export LESS="-XFR"
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

### PATH
# .config
export XDG_CONFIG_HOME="$HOME/.config"

# Heroku
export PATH="/usr/local/opt/heroku-node/bin:$PATH"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
