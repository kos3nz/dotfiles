### Aliases ###
alias ...='cd ../..'
alias ....='cd ../../..'
alias d-='cd -'
alias d_='cd $_'
alias c='code' # Vscodeを開く(usage: c <file | dir> でファイル(ディレクトリ)を開く)
alias c.='code .'
alias sz='source ~/.config/zsh/.zshrc'
alias szsh='source ~/.config/zsh/.zshrc'
alias port='lsof -i' # ポートのプロセスを調べる -> lsof -i :3000
alias pkill='kill -9' # プロセスをkill (-9 = 強制終了) -> kill -9 [PIDの数字]
alias restart='sudo fdesetup authrestart'
alias delcache='sudo rm -rf /System/Library/Caches/* /Library/Caches/* ~/Library/Caches/*' # Macのキャッシュを削除


# bat
if type "bat" > /dev/null 2>&1; then
    alias cat="bat"
fi

# eza
if type "eza" > /dev/null 2>&1; then
    alias ls='eza --icons=always'
    alias l='eza -F --icons=always'
    alias la='eza -a --icons=always'
    alias ll='eza -alh --icons=always'
    alias l1='eza -1 --icons=always'
    alias tree='eza --tree -a --icons=always'
fi

# lf
if type "lf" > /dev/null 2>&1; then
    alias lf="lfcd"
fi

# lazygit
if type "lazygit" > /dev/null 2>&1; then
    alias lg='lazygit'
fi

# neovim
if type "nvim" > /dev/null 2>&1; then
    alias v='nvim'
    alias vi='nvim'
    alias nv='nvim'
    alias vh='nvim ~/.local/state/zsh/zsh_history'
fi

# rm/trash
if type "trash" > /dev/null 2>&1; then
    alias rm="trash"
    alias rm-p="trash-put"
    alias rm-e="trash-empty"
    alias rm-l="trash-list"
    alias rm-s="trash-restore"
    alias rm-d="trash-rm"
fi

# Git && Github
# alias g='git'
# alias gin='git init'
# alias gs='git status'
# alias gb='git branch' # ブランチ作成 ($ git branch <branchName>)
# alias gba='git branch -a' # ブランチの一覧を見る
# alias gc='git checkout'
# alias gcb='git checkout -b' # branchを作成してcheckout
# alias gchm='git checkout main'
# alias gchms='git checkout master'
# alias gpuo='git push -u origin' # ブランチをリモートに登録 ($ git push -u origin <branchName>)
# alias gct='git commit'
# alias gg='git grep'
# alias ga='git add'
# alias gd='git diff'
# alias gl='git log'
# alias glg='git log --graph'
# alias glgo='git log --graph --oneline'
# alias graph='git log --all --decorate --oneline --graph'
# alias gfu='git fetch upstream'
# alias gfo='git fetch origin'
# alias gm='git merge'
# alias gmod='git merge origin/develop'
# alias gmud='git merge upstream/develop'
# alias gmom='git merge origin/main'
# alias gmoms='git merge origin/master'
# alias gcm='git commit -m'
# alias gcam='git commit -am' # add + commit & message
# alias gcamm='git commit --amend -m' # 直前のコミットのメッセージを修正
# alias gcane='git commit --amend --no-edit' # コードを修正した後、コミットメッセージを変更せずに最新のコミットに上書き
# alias grbi='git rebase -i' # git rebase -i HEAD~3 で3つ前までのコミットのコメントを修正できる (pick -> edit に変更して保存。git commit --amend -m でもう一度コメントを書き直し、git rebase --continue で最新のコミットに戻る。(editするコミットが2つ以上ある場合は、次のeditするコミットに移る))
# alias grbc='git rebase --continue'
# alias grset='git reset --soft HEAD\^' # 直前のコミットを取り消し (--soft: コミット取り消し&ワークディレクトリはそのまま)
# alias grseth='git reset --hard HEAD\^' # (--hard : コミット取り消し&ワークディレクトリの内容書き換え, HEAD^: 直前のコミット) HEAD^^^とHEAD~3とHEAD~~~とHEAD~{3}と@^^^は同じ意味
# alias gpo='git push origin'
# alias gpom='git push origin main'
# alias gpoms='git push origin master'
# alias gpoh='git push origin HEAD' # branch名を書かずともbranchにpushできる
# alias gploh='git pull origin HEAD' # branch名を書かずともbranchにpushできる
# alias gst='git stash'
# alias gsl='git stash list'
# alias gsu='git stash -u'
# alias gsp='git stash pop'
# alias ggpull='git pull origin $(current_branch)' # 現在いるbranchをoriginからpull
# alias ggpush='git push origin $(current_branch)' # originに今いるbranchをpush
# alias gibonv='gibo dump Node VisualStudioCode >> .gitignore' # .gitignoreにテンプレートを上書き
# alias gres='git restore'
# alias gr='git remote' # check remote branches
# alias grrm='git remote remove' # remove remote branch
# alias gra='git remote add'
# alias grao='git remote add origin' # grao (remote repo) でリモートリポジトリ追加
# alias grsurlo='git remote set-url origin' # git remote set-url origin {new url} リモートURL変更
# alias grmrc='git rm -r --cached .' # ファイル全体キャッシュ削除

alias bsls='brew services list'
alias bss='brew services start'
alias bst='brew services stop'

# Docker
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dc_build_up='docker compose rm -fv && docker-compose build && docker-compose up'
alias rm_docker_images='docker images -qf dangling=true | xargs docker rmi'
alias rm_docker_containers='docker ps -aqf status=exited | xargs docker rm -v' # rm with volumes
alias rm_docker_volumes='docker volume ls -qf dangling=true | xargs docker volume rm'
alias rm_docker_compose_containers='docker-compose rm -fv'
alias dsyspru='docker system prune'

# Kubernetes
alias k='kubectl'

# ghq
alias gq='ghq get' # リポジトリをghq管理下へ取得
alias gqls='ghq list' # ghq管理下のリポジトリ一覧
alias gqud='ghq list | ghq get --update --parallel' #手元の管理リポジトリを一括で最新の状態に更新
alias gqtx='ghq list > repolist.txt' # ghq管理下のリポジトリ一覧をテキストファイルに保存
alias gqtx_local='ghq get --update --parallel < repolist.txt' # ghq管理下のリポジトリ一覧をテキストファイルから一括で最新の状態に更新(別マシンへのリポジトリ移行時に使用)
alias gqroot='git config --global ghq.root' # ghqのrootディレクトリをgit configで設定
alias gqmv='GHQ_MIGRATOR_ACTUALLY_RUN=1 ./ghq-migrator.bash' # ghq管理下へローカルリポジトリを移動(ghq-migratorディレクトリへ移動したあと、'gqmv ~/foo'でfooリポジトリをghq管理下へ移動)

# Shopify CLI
alias sp="shopify"
alias h2="npx shopify hydrogen"

# Tmux
alias ta='tmux attach'
alias tl='tmux ls'
alias tn='tmux new-session -A -s $(basename "`pwd`")' # カレントディレクトリ名でセッション作成

# ディレクトリ管理
alias cleancdr='clean-cdr > ~/chpwd-recent-dirs-clean && mv ~/chpwd-recent-dirs-clean ~/.local/state/zsh/chpwd-recent-dirs' # 存在しないディレクトリを .chpwd-recent-dir から削除

# Custom functions
alias fb="find-and-bat"
alias pk="fzf-process-kill"
