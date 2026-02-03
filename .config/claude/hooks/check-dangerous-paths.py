#!/usr/bin/env python3
# Blocks Edit/Write operations on dangerous files

import json
import re
import sys

data = json.load(sys.stdin)
path = data.get('tool_input', {}).get('file_path', '')

dangerous = [
    r'\.env(\.|$)',  # .env or .env.local, .env.production, etc
    r'.*-lock\.(json|yaml|yml)$',  # package-lock.json, yarn-lock.yaml, etc
    r'\.lock$',  # Gemfile.lock, poetry.lock, etc
    r'(^|/)\.git/',  # .git directory
    r'(^|/)node_modules/',  # node_modules directory
    r'(^|/)dist/',  # dist directory
    r'(^|/)build/',  # build directory
    r'(^|/)\.next/',  # .next directory
    r'(^|/)coverage/',  # coverage directory
]

sys.exit(2 if any(re.search(p, path) for p in dangerous) else 0)
