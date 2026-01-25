#!/bin/bash

input=$(cat)
cwd=$(echo "$input" | sed -n 's/.*"current_dir":"\([^"]*\)".*/\1/p')

if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  staged=$(git -C "$cwd" --no-optional-locks diff --cached --name-only 2>/dev/null | wc -l)
  modified=$(git -C "$cwd" --no-optional-locks diff --name-only --diff-filter=M 2>/dev/null | wc -l)
  untracked=$(git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard :/ 2>/dev/null | wc -l)
  deleted=$(git -C "$cwd" --no-optional-locks diff --name-only --diff-filter=D 2>/dev/null | wc -l)

  printf '\033[32mS:%d\033[0m  \033[33mM:%d\033[0m  \033[35m?:%d\033[0m  \033[31mD:%d\033[0m' \
    "$staged" "$modified" "$untracked" "$deleted"
else
  echo ""
fi
