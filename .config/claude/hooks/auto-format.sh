#!/bin/bash

# Auto-format files after Edit/Write operations
file_path=$(jq -r '.tool_input.file_path' 2>/dev/null)

if [ -z "$file_path" ] || [ ! -f "$file_path" ]; then
  exit 0
fi

# Format TypeScript/JavaScript files with Prettier if available
if echo "$file_path" | grep -qE '\.(ts|tsx|js|jsx|json|css|scss|md)$'; then
  if command -v npx &> /dev/null && [ -f "$(dirname "$file_path")/package.json" ] || [ -f "./package.json" ]; then
    npx prettier --write "$file_path" 2>/dev/null || true
  fi
fi

# Format Python files with black if available
if echo "$file_path" | grep -qE '\.py$'; then
  if command -v black &> /dev/null; then
    black "$file_path" 2>/dev/null || true
  fi
fi

exit 0
