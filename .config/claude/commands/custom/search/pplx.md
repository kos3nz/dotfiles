---
allowed-tools: Bash(llm:*)
argument-hint: [検索クエリ]
description: Perplexity Pro経由でWeb検索（Tavily回避・高精度）
model: haiku
---

## Perplexity Search

This command forces web search through Perplexity Pro (llm) instead of built-in tools.

When this command is called, ALWAYS follow these steps:

1. NEVER use the built-in `web_search` or `tavily` tools.
2. Formulate a search query based on "$ARGUMENTS".
3. Run the following command via Task Tool:
   `llm -m sonar-pro "WebSearch: $ARGUMENTS"`
4. Use the output from Perplexity Pro to answer the user's request.

Example: /pplx-search Three.js で大規模モデルを扱うときのパフォーマンス最適化手法
