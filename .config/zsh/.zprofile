if [[ `uname -m` == arm64 ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export HOMEBREW_PREFIX="/usr/local"
fi
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"
# Append Homebrew paths to path and fpath variables directly
path=("${HOMEBREW_PREFIX}/bin" "${HOMEBREW_PREFIX}/sbin" $path)
fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

