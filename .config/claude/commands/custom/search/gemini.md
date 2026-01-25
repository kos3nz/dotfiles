---
allowed-tools: Bash(gemini:*)
argument-hint: [検索クエリ]
description: Gemini CLI経由でWeb検索（Tavily回避）
model: haiku
---

## Gemini Search

This command forces web search through Gemini CLI instead of built-in tools.

When this command is called, ALWAYS follow these steps:

1. NEVER use the built-in `web_search` or `tavily` tools.
2. Formulate a search query based on "$ARGUMENTS".
3. Run the following command via Task Tool:
   `gemini "WebSearch: $ARGUMENTS"`
4. Use the output from Gemini to answer the user's request.

Example: /gemini-search Gemini CLI の最新バージョンと主要な新機能
