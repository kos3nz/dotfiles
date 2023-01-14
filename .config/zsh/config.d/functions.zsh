### Functions ###
#
# BUFFER : コマンドラインとして編集している文字列が格納される変数
#          この変数に任意の文字列を入れると、実際にコマンドラインの文字列も置き換わる
#
# CURSOR : カーソルの位置が格納される変数
#          この変数に数値を入れると、実際にコマンドラインのカーソル位置が移動する
#
# zle redisplay : 画面のリフレッシュ
#
# zle -N my_edit_func : my_edit_funcをZLEウィジェットというものとして登録する
#                       おまじない的に必ずつけるものだと思えば良い
#
# bindkey "^j" my_edit_func : ctrl+jにウィジェットmy_edit_funcを紐づける
#

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
function fzgrep() {
  INITIAL_QUERY=""
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --phony --query "$INITIAL_QUERY" \
        --preview 'bat `echo {} | cut -f 1 --delim ":"`'
}

# iTerm2のコマンドの真ん中に移動
function jump_middle() {
    CURSOR=$((${#BUFFER} / 2))
    zle redisplay
}
zle -N jump_middle
bindkey "^j" jump_middle

# Node Scriptを参照
function nsc() {
    if [[ -f package.json ]]; then
        printf "\033[36m%-44s\033[0m %-20s\n" "[Command]" "[Description]"
        cat package.json | jq ".scripts" | grep : | sed -e 's/,//g' |  awk -F "\": \"" '{printf "(npm run|yarn)\033[36m%-30s\033[0m %-20s\n", $1, $2}' | sed -e 's/\"//g'
    fi
}
