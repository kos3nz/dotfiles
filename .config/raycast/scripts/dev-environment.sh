#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Development Environment
# @raycast.mode fullOutput
# @raycast.icon 🛠️
# @raycast.packageName Development
# @raycast.description Show tool versions, managers, and executable paths

# -u は未設定の変数をエラーにし、pipefail はパイプ途中の失敗も拾う。
# 個別ツールの取得失敗でも続行するため、即終了する -e は指定しない。
set -uo pipefail

# $'...' 内の \033 は ESC 文字（8進数 033）。ESC[...m で表示属性を指定する。
# 38;2;R;G;B の 38 は文字色、2 は RGB 形式の識別番号（値の個数ではない）。
# ESC[0m で属性をリセットし、reset では続けて通常の文字色を指定する。
reset=$'\033[0m\033[38;2;205;214;244m'
cyan=$'\033[38;2;137;220;235m'
green=$'\033[38;2;166;227;161m'
yellow=$'\033[38;2;249;226;175m'
manager_color=$'\033[38;2;137;180;250m'
unknown_color=$'\033[38;2;127;132;156m'

# プロジェクト内のバージョン指定を拾わないよう、ホームを基準に実行する。
cd "$HOME" || exit 1

# $(...) で CPU 種別を取得し、Homebrew の標準パスを選ぶ。
case "$(/usr/bin/uname -m)" in
arm64) brew_prefix=/opt/homebrew ;;
*) brew_prefix=/usr/local ;;
esac

# Bash 内から外部コマンド（rustcなど）を起動する際、子プロセスに export 済みの環境変数が引き継がれる。
# ${変数:-代替値} は未設定・空の場合の既定値。export で子プロセスにも渡す。
# 例: CARGO_HOME → XDG_DATA_HOME/cargo → ~/.local/share/cargo の順で選ぶ。
export CARGO_HOME="${CARGO_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/rustup}"
mise_data_dir="${MISE_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/mise}"
rbenv_root="${RBENV_ROOT:-$HOME/.rbenv}"

# 対話シェルの設定に依存せず、PATH を用意する。左側のディレクトリが優先される。
export PATH="$HOME/.local/bin:$brew_prefix/opt/rustup/bin:$CARGO_HOME/bin:$rbenv_root/shims:$brew_prefix/bin:$brew_prefix/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# command -v で存在確認。>/dev/null 2>&1 で標準出力・標準エラーを捨てる。
if command -v mise >/dev/null 2>&1; then
  # 先頭の VAR=値 はこのコマンドだけに適用され、自動インストール・通信を無効にする。
  if mise_paths="$(MISE_AUTO_INSTALL=false MISE_OFFLINE=true mise -q bin-paths)"; then
    # ${変数//検索/置換} で改行を : に変え、mise のパスを先頭に足す。
    export PATH="${mise_paths//$'\n'/:}:$PATH"
  else
    printf '%sWarning: could not load mise tool paths.%s\n\n' "$yellow" "$reset"
  fi
fi

rustup_executable="$(command -v rustup || true)"

# 実行パスとコマンド名から管理元を判定する。結果は標準出力へ出し、$(...) で受け取る。
tool_manager() {
  local executable="$1" command_name="$2"

  # case の * は前方一致、| は候補の区切り。インストール元よりバージョン管理元を優先する。
  case "$executable" in
  "$mise_data_dir/installs/"* | "$mise_data_dir/shims/"*)
    printf 'mise'
    return
    ;;
  "$rbenv_root/shims/"* | "$rbenv_root/versions/"*)
    printf 'rbenv'
    return
    ;;
  "$RUSTUP_HOME/toolchains/"*)
    printf 'rustup'
    return
    ;;
  esac

  # -ef はリンク先も含む同一ファイル判定。Homebrew 版 rustup のラッパーも rustup 扱いにする。
  case "$command_name" in
  rustc | cargo)
    if [[ -n "$rustup_executable" && "$executable" -ef "$rustup_executable" ]] ||
      [[ "$executable" == "$brew_prefix/opt/rustup/bin/"* || "$executable" == "$brew_prefix/Cellar/rustup/"* ]]; then
      printf 'rustup'
      return
    fi
    ;;
  esac

  case "$executable" in
  "$brew_prefix/bin/"* | "$brew_prefix/sbin/"* | "$brew_prefix/opt/"* | "$brew_prefix/Cellar/"*) printf 'Homebrew' ;;
  /usr/bin/* | /bin/* | /usr/sbin/* | /sbin/*) printf 'macOS' ;;
  *) printf 'Unknown' ;;
  esac
}

# 配列は (...)、要素数は ${#配列[@]}。=() で初期化・クリアし、+=(...) で末尾に追加する。
column_headers=(Tool Version Manager Path)
column_count=${#column_headers[@]}
column_widths=()
section_title=''
# セルは4要素で1行、色は1要素で1行として対応させる。
section_cells=()
section_colors=()

# 1行を出力する。%-*s は左揃えで、引数から「列幅」「値」を順に受け取る。
print_row() {
  local label="$1" version="$2" manager="$3" executable="$4"
  local version_color="$5" manager_cell_color="$6"
  [[ "$version" == 'Unknown' ]] && version_color="$unknown_color"
  [[ "$manager" == 'Unknown' ]] && manager_cell_color="$unknown_color"
  printf '%-*s  %s%-*s%s  %s%-*s%s  %s\n' \
    "${column_widths[0]}" "$label" "$version_color" "${column_widths[1]}" "$version" "$reset" \
    "$manager_cell_color" "${column_widths[2]}" "$manager" "$reset" "$executable"
}

# 収集済みのセクションについて列幅を計算し、見出し・罫線・全行を表示する。
render_section() {
  # 最初の show_section 呼び出し時は、まだ表示するセクションがない。
  [[ -n "$section_title" ]] || return 0
  local index column value width separator
  local dividers=()

  # ${!配列[@]} は添字の一覧、${#配列[添字]} は文字数。色コードを含めず列幅を測る。
  for column in "${!column_headers[@]}"; do
    column_widths[column]=${#column_headers[column]}
  done
  for index in "${!section_cells[@]}"; do
    column=$((index % column_count))
    value="${section_cells[index]}"
    if ((${#value} > column_widths[column])); then
      column_widths[column]=${#value}
    fi
  done
  for width in "${column_widths[@]}"; do
    # printf -v で列幅ぶんの空白を変数に保存し、- に置換して罫線にする。
    printf -v separator '%*s' "$width" ''
    dividers+=("${separator// /-}")
  done

  # "${配列[@]}" は各要素を別々の引数に展開する。空白を含む値も1引数のまま渡せる。
  printf '\n\n%s%s%s\n\n' "$cyan" "$section_title" "$reset"
  print_row "${column_headers[@]}" "$reset" "$reset"
  print_row "${dividers[@]}" "$reset" "$reset"
  for ((index = 0; index < ${#section_cells[@]}; index += column_count)); do
    # ${配列[@]:開始位置:個数} で1行を取り出し、対応する行番号の色を渡す。
    print_row "${section_cells[@]:index:column_count}" "${section_colors[index / column_count]}" "$manager_color"
    printf '\n'
  done
}

# 最長値から列幅を決めるため、前の表をまとめて描画してから次の表の収集を始める。
show_section() {
  render_section
  section_title="$1"
  section_cells=()
  section_colors=()
}

# 表示名・コマンド名・確認用の引数を受け取り、1ツールの情報を描画用の配列に追加する。
show_tool() {
  local label="$1" command_name="$2" executable output manager version status=0
  local version_color="$green" version_pattern='[0-9]+([.][0-9]+)+[[:alnum:].+-]*'
  # shift 2 で先頭2引数を除く。残った "$@" が --version などの引数になる。
  shift 2

  if ! executable="$(command -v "$command_name")"; then
    section_cells+=("$label" 'Not found' '-' '-')
    section_colors+=("$yellow")
    return
  fi

  # 失敗時は $?（終了コード）を保存して続行。2>/dev/null で標準エラーを除く。
  output="$("$executable" "$@" 2>/dev/null)" || status=$?
  # \r を除去し、%% で最初の改行以降を切り落として1行目だけにする。
  output="${output//$'\r'/}"
  output="${output%%$'\n'*}"

  if ((status != 0)); then
    version="Failed (exit $status)"
    version_color="$yellow"
  elif [[ "$output" =~ $version_pattern ]]; then
    # =~ は正規表現との照合。BASH_REMATCH[0] に一致したバージョン全体が入る。
    version="${BASH_REMATCH[0]}"
  else
    version='Unknown'
    version_color="$yellow"
  fi

  manager="$(tool_manager "$executable" "$command_name")"
  if [[ "$executable" == "$HOME/"* ]]; then
    # ${変数#接頭辞} でホーム部分を取り除き、表示用に ~ を付ける。
    executable="~${executable#"$HOME"}"
  fi
  section_cells+=("$label" "$version" "$manager" "$executable")
  section_colors+=("$version_color")
}

printf '%sDevelopment Environment%s\n\nScope: Home defaults\n' "$cyan" "$reset"

# 表示対象の定義。追加するときは show_tool 表示名 コマンド 引数... の行を足す。
show_section 'Languages & Runtimes'
show_tool Node.js node --version
show_tool Python python3 --version
show_tool PHP php --version
show_tool Ruby ruby --version
show_tool Go go version
show_tool Rust rustc --version
show_tool Bun bun --version
show_tool Deno deno --version

show_section 'Package Managers'
show_tool npm npm --version
show_tool pnpm pnpm --version
show_tool Yarn yarn --version
show_tool uv uv --version
show_tool Composer composer --version --no-ansi
show_tool Bundler bundle --version
show_tool Cargo cargo --version

show_section 'Environment & Developer Tools'
show_tool mise mise --version
show_tool rbenv rbenv --version
show_tool rustup rustup --version
show_tool Homebrew brew --version
show_tool Git git --version
# 次の show_section がない最後の表は、ここで明示的に表示する。
render_section
printf '\033[0m'
