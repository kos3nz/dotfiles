#!/usr/bin/env python3
# Blocks Edit/Write operations on dangerous files

import json
import sys

data = json.load(sys.stdin)
path = data.get('tool_input', {}).get('file_path', '')

dangerous = [
    '.env.*',
    '.*-lock\\.(json|yaml|yml)|\\.lock$',
    '.git/',
    'node_modules/',
    'dist/',
    'build/',
    '.next/',
    'coverage/'
]

sys.exit(2 if any(p in path for p in dangerous) else 0)
