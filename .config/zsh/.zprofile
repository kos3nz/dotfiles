# =============================================================================
# Homebrew Setup (Optimized for macOS)
# =============================================================================
# Avoids the extremely slow `brew shellenv` which calls macOS `path_helper` under the hood.
# Hardcoding the Homebrew paths based on CPU architecture makes startup instantaneous.
if [[ `uname -m` == arm64 ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export HOMEBREW_PREFIX="/usr/local"
fi
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"

# Standard system paths (Explicitly defined for safety when skipping path_helper)
path=(
  "${HOMEBREW_PREFIX}/bin"
  "${HOMEBREW_PREFIX}/sbin"
  "/usr/local/bin"
  "/usr/bin"
  "/bin"
  "/usr/sbin"
  "/sbin"
  $path
)
export PATH

fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)

# =============================================================================
# OrbStack Integration
# =============================================================================
# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
