# =============================================================================
# Navigation & System Aliases
# =============================================================================
alias ...='cd ../..'
alias ....='cd ../../..'
alias d-='cd -'
alias d+='cd $_'
alias sz='source "$HOME/.config/zsh/.zshrc"'
alias szsh='source "$HOME/.config/zsh/.zshrc"'
alias port='lsof -i' # ポートのプロセスを調べる -> lsof -i :3000
alias pkill='kill -9' # プロセスをkill (-9 = 強制終了) -> kill -9 [PIDの数字]
alias restart='sudo fdesetup authrestart'
alias delcache='sudo rm -rf /System/Library/Caches/* /Library/Caches/* ~/Library/Caches/*' # Macのキャッシュを削除

# homebrew
alias bsls='brew services list'
alias bss='brew services start'
alias bst='brew services stop'

# ディレクトリ管理
alias cleancdr='clean-cdr > ~/chpwd-recent-dirs-clean && mv ~/chpwd-recent-dirs-clean ~/.local/state/zsh/chpwd-recent-dirs' # 存在しないディレクトリを .chpwd-recent-dir から削除

# Custom functions
alias fb="find-and-bat"
alias pk="fzf-process-kill"

# =============================================================================
# Modern CLI Replacements (Static aliases for performance)
# =============================================================================
# Note: Removed 'if type' checks as they are slow on cold disk cache.
# If a tool is missing, shell simply errors on use, but startup stays fast.

# bat
alias cat="bat"

# eza
alias ls='eza --icons=always'
alias l='eza -F --icons=always'
alias la='eza -a --icons=always'
alias ll='eza -alh --icons=always'
alias l1='eza -1 --icons=always'
alias tree='eza --tree -a --icons=always'

# lf
alias lf="lfcd"

# neovim
alias v='nvim'
alias vi='nvim'
alias nv='nvim'
alias vh='nvim ~/.local/state/zsh/zsh_history'

# rm/trash
alias rm="trash"

# =============================================================================
# Containers & Orchestration
# =============================================================================
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

# =============================================================================
# Development Tools & LLMs
# =============================================================================
# ghq
alias gq='ghq get' # リポジトリをghq管理下へ取得
alias gqls='ghq list' # ghq管理下のリポジトリ一覧
alias gqud='ghq list | ghq get --update --parallel' #手元の管理リポジトリを一括で最新の状態に更新
alias gqtx='ghq list > repolist.txt' # ghq管理下のリポジトリ一覧をテキストファイルに保存
alias gqtx_local='ghq get --update --parallel < repolist.txt' # ghq管理下のリポジトリ一覧をテキストファイルから一括で最新の状態に更新(別マシンへのリポジトリ移行時に使用)
alias gqroot='git config --global ghq.root' # ghqのrootディレクトリをgit configで設定
alias gqmv='GHQ_MIGRATOR_ACTUALLY_RUN=1 ./ghq-migrator.bash' # ghq管理下へローカルリポジトリを移動(ghq-migratorディレクトリへ移動したあと、'gqmv ~/foo'でfooリポジトリをghq管理下へ移動)

# Tmux
alias ta='tmux attach'
alias tl='tmux ls'
alias tn='tmux new-session -A -s $(basename "`pwd`")' # カレントディレクトリ名でセッション作成

# Shopify
alias sp="shopify"
alias h2="npx shopify hydrogen"

# Claude Code
alias c='claude'
alias cc='claude --continue'
alias cyolo='claude --dangerously-skip-permissions'

# Codex
alias cx='codex'

# Opencode
alias oc='opencode'
alias occ='opencode --continue'

# LLM
alias llmm="llm models"
alias llmkl="llm keys list"
alias llmkp="llm keys path"
alias pplx="llm -m sonar-pro"
alias gmn="llm -m gemini-3-flash-preview"

