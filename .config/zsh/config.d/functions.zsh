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
#
# bindkey "^j" my_edit_func : ctrl+jにウィジェットmy_edit_funcを紐づける


# pk で実行中のプロセスを選択して kill
function fzf-process-kill() {
  for pid in `ps aux | fzf | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
zle -N fzf-process-kill


# search a destination from cdr list
function fzf-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  # fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} --
  fzf
}
# search a destination from cdr list and cd the destination
function fzf-cdr() {
  local target_dir="$(fzf-get-destination-from-cdr)"
  if [ -n "$target_dir" ]; then
    BUFFER="cd $target_dir"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N fzf-cdr


function clean-cdr() {
  cat "$XDG_STATE_HOME/zsh/chpwd-recent-dirs" \
    | sed -e 's/^..\(.*\)./\1/g' \
    | while read line
  do
    if [ -d "$line" ]; then
      echo "\$'$line'"
    fi
  done
}
zle -N clean-cdr


# ghqとの連携。ghqの管理化にあるリポジトリを一覧表示する。
function fzf-ghq () {
  # local selected_dir=$(ghq list -p | fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- )
  local selected_dir=$(ghq list -p | fzf )
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-ghq


# ターミナルコマンドの真ん中に移動
function jump_middle() {
    CURSOR=$((${#BUFFER} / 2))
    zle redisplay
}
zle -N jump_middle


# Node Scriptを参照
function nsc() {
    if [[ -f package.json ]]; then
        printf "\033[36m%-44s\033[0m %-20s\n" "[Command]" "[Description]"
        cat package.json | jq ".scripts" | grep : | sed -e 's/,//g' |  awk -F "\": \"" '{printf "(npm run|yarn)\033[36m%-30s\033[0m %-20s\n", $1, $2}' | sed -e 's/\"//g'
    fi
}
zle -N nsc 

# Highlighting `--help` message (ex: $help gh, help git commit)
function help() {
    "$@" --help 2>&1 | bat --plain --language=help
}
zle -N help 

### navi ###
_navi_call() {
   local result="$(navi "$@" </dev/tty)"
   printf "%s" "$result"
}
navi_widget() {
   local -r input="${LBUFFER}"
   local -r last_command="$(echo "${input}" | navi fn widget::last_command)"
   local replacement="$last_command"

   if [ -z "$last_command" ]; then
      replacement="$(_navi_call --print)"
   elif [ "$LASTWIDGET" = "navi_widget" ] && [ "$input" = "$previous_output" ]; then
      replacement="$(_navi_call --print --query "$last_command")"
   else
      replacement="$(_navi_call --print --best-match --query "$last_command")"
   fi

   if [ -n "$replacement" ]; then
      local -r find="${last_command}_NAVIEND"
      previous_output="${input}_NAVIEND"
      previous_output="${previous_output//$find/$replacement}"
   else
      previous_output="$input"
   fi

   zle kill-whole-line
   LBUFFER="${previous_output}"
   region_highlight=("P0 100 bold")
   zle redisplay
}
zle -N navi_widget

### lf ###
lfcd() {
  tmp="$(mktemp)"
  # `command` is needed in case `lfcd` is aliased to `lf`
  command lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  fi
}
zle -N lfcd
