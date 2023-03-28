# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"


### zinit ###
typeset -gAH ZINIT
ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit"
ZINIT[ZCOMPDUMP_PATH]="$XDG_STATE_HOME/zsh/zcompdump"
source "${ZINIT[HOME_DIR]}/zinit.git/zinit.zsh"

### Added by Zinit's installer

if [[ ! -f ${ZINIT[HOME_DIR]}/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "${ZINIT[HOME_DIR]}" && command chmod g-rwX "${ZINIT[HOME_DIR]}"
    command git clone https://github.com/zdharma-continuum/zinit "${ZINIT[HOME_DIR]}/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


### Load seperated config files ###
for conf in "$XDG_CONFIG_HOME/zsh/config.d/"*.zsh; do
  source "${conf}"
done
unset conf


### options ###
setopt auto_cd # changes current directory without typing `cd`
cdpath=(.. ~ ~/ghq/github.com) # 親ディレクトリやホームディレクトリ，~/ghq/github.com 以下へはどこからでもディレクトリ名だけで移動できる


### History ###
HISTFILE="$XDG_STATE_HOME/zsh/zsh_history"      # ヒストリファイルを指定
HISTSIZE=10000               # ヒストリに保存するコマンド数
SAVEHIST=10000               # ヒストリファイルに保存するコマンド数
setopt HIST_IGNORE_ALL_DUPS  # 重複するコマンド行は古い方を削除
setopt HIST_IGNORE_DUPS      # 直前と同じコマンドラインはヒストリに追加しない
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY         # コマンド履歴ファイルを共有する
setopt APPEND_HISTORY        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt INC_APPEND_HISTORY    # 履歴をインクリメンタルに追加
# setopt HIST_NO_STORE         # historyコマンドは履歴に登録しない
setopt HIST_REDUCE_BLANKS    # 余分な空白は詰めて記録

# 不要なコマンドをhistoryから除外する
# 返り値が`0`の場合はhistoryに保存され、`0`以外は除外される。
zshaddhistory() {
  # 特定のコマンドを保存しない
  local line="${1%%$'\n'}" # コマンドラインから改行文字を除去 (${name%%pattern} syntax) 
  [[ "$line" =~ "^(buildin|cd|lg|lazygit|la|ll|exa|rm|rmdir|navi)($| )" ]] && return 1 

  # 失敗したコマンドを保存しない: http://www.zsh.org/mla/users//2014/msg00715.html
  whence ${${(z)1}[1]} >| /dev/null || return 1
}


### Shell prompt ###
# load starship theme
eval "$(starship init zsh)"


### Key Bindings ###
bindkey -e # e-macs keybindings
bindkey "^j" jump_middle
bindkey '^o' fzf-cdr
bindkey '^v' navi_widget
bindkey '^]' fzf-ghq
# fzf (fzf-history-widget: ^R, fzf-cd-widget: ^[c, fzf-file-widget: ^T )
bindkey -r '^[c'
bindkey '^g' fzf-cd-widget


### Paths ###
typeset -U path
# typeset -U fpath

path=(
  "$HOME/.config/alacritty/bin"(N-/)
  "$VOLTA_HOME/bin"(N-/)
  "$XDG_CONFIG_HOME/tmux/plugins/t-smart-tmux-session-manager/bin"(N-/)
  $path
)

# fpath=()


### Async Loading ###
zinit wait lucid light-mode as'null' \
    atinit'source "$ZDOTDIR/.zshrc.lazy"' \
    for 'zdharma-continuum/null'


# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
