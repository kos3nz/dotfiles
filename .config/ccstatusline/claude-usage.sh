#!/bin/bash
# Claude usage bar for the ccstatusline custom-command widget.
# Reads the Claude Code statusline JSON on stdin and uses the native `rate_limits`
# field, so it makes NO API call (zero lag, no apiError). Recomputes on each
# render (startup + after every prompt), which is exactly when ccstatusline runs.
#
# The bar shows REMAINING quota (100 - used), fuel-gauge style: a full bar means
# plenty left, an empty bar means nearly exhausted.
#
# Usage: claude-usage.sh five_hour|seven_day
#   five_hour -> "5h ●●●●●●●●○○ 76% ⟳ 3hr 2min"
#   seven_day -> "7d ●●●○○○○○○○ 27% ⟳ Sun 10:00pm"

window="${1:-five_hour}"
input=$(cat)

# rate_limits only appears AFTER the first API response in a session, so it is
# absent at startup. Cache the last seen value (account-global, per window) and
# fall back to it at startup so the bar shows immediately instead of blank.
cache="${TMPDIR:-/tmp}/ccstatusline-usage-${window}"

# Pull the percentage and reset epoch for this window in one jq pass.
# Emits "ABSENT" when rate_limits (or this window) is missing.
vals=$(printf '%s' "$input" | jq -r --arg w "$window" '
  .rate_limits[$w] as $r
  | if $r == null or $r.used_percentage == null then "ABSENT"
    else "\($r.used_percentage)\t\($r.resets_at // 0)" end')

if [ "$vals" = "ABSENT" ]; then
  [ -f "$cache" ] || exit 0 # nothing cached yet (very first launch)
  vals=$(cat "$cache")      # show last known value until fresh data lands
else
  printf '%s' "$vals" >"$cache" # fresh data — refresh the cache
fi

IFS=$'\t' read -r percentage resets <<<"$vals"
percentage=${percentage%.*} # floor used % to an integer
[ -z "$percentage" ] && exit 0
remaining=$((100 - percentage)) # show REMAINING quota
((remaining < 0)) && remaining=0

WIDTH=10
filled=$(((remaining * WIDTH + 99) / 100)) # ceil for filled usage dots
((filled > WIDTH)) && filled=$WIDTH
((filled < 0)) && filled=0
empty=$((WIDTH - filled))

DIM=$'\033[90m'
RESET=$'\033[0m'
WHITE=$'\033[97m'
if ((remaining <= 10)); then
  C=$'\033[31m' # red    — almost out
elif ((remaining <= 30)); then
  C=$'\033[33m' # yellow — running low
else
  C=$'\033[32m' # green  — healthy
fi

dots=""
for ((i = 0; i < filled; i++)); do dots+="● "; done
empty_dots=""
for ((i = 0; i < empty; i++)); do empty_dots+="○ "; done
empty_dots="${empty_dots% }" # drop the trailing space on the last dot
[ -z "$empty_dots" ] && dots="${dots% }"

if [ "$window" = "five_hour" ]; then
  label="5h"
  secs=$((resets - $(date +%s)))
  ((secs < 0)) && secs=0
  h=$((secs / 3600))
  m=$(((secs % 3600) / 60))
  ((h > 0)) && rs="${h}hr ${m}min" || rs="${m}min"
else
  label="7d"
  rs=$(date -r "$resets" '+%a %-I:%M%p' 2>/dev/null | sed 's/AM$/am/; s/PM$/pm/')
fi

reset_seg=""
[ -n "$rs" ] && [ "$resets" != "0" ] && reset_seg=" ${DIM}󰑓 ${WHITE}${rs}${RESET}"

printf '%s%-2s%s %s%s%s%s %s%d%%%s%s' \
  "$DIM" "$label" "$RESET" "$C" "$dots" "$DIM" "$empty_dots" "$WHITE" "$remaining" "$RESET" "$reset_seg"
