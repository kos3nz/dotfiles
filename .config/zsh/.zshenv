# Skip macOS system-wide path_helper for high-speed startup
export __ETC_ZPROFILE_SOURCED=1

# =============================================================================
# XDG Base Directory Specification
# =============================================================================
# cleaning up home folder
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# =============================================================================
# Zsh Base Configuration
# =============================================================================
export ZDOTDIR="$HOME/.config/zsh"
