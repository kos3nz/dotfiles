#!/bin/bash

# Enhanced notify-slack.sh that handles both Notification and Stop hooks
# Replace YOUR_WEBHOOK_URL with your actual Slack webhook URL

# Check jq dependency
if ! command -v jq &>/dev/null; then
  echo "Error: jq required" >&2
  exit 1
fi

# Check if notifications are enabled
if [[ "${SLACK_NOTIFICATION}" == "false" ]]; then
  echo "Slack notifications disabled" >&2
  exit 0
fi

# Slack Webhook URL (replace with your actual URL)
WEBHOOK_URL="${SLACK_WEBHOOK_URL}"

if [ -z "$WEBHOOK_URL" ]; then
  echo "Error: SLACK_WEBHOOK_URL not set" >&2
  exit 1
fi

# Claude Code sends JSON data via stdin, so we read it into a variable
INPUT=$(cat)

# Check for empty input
if [ -z "$INPUT" ]; then
  echo "Error: No input" >&2
  exit 1
fi

# Debug: Log the raw input to see what we're receiving
# echo "[DEBUG] $(date) - Received input: $INPUT" >> ~/.config/claude/hooks/notification-debug.log

# Determine which hook triggered this script
# The Stop hook doesn't have 'message' or 'title' fields
if echo "$INPUT" | jq -e 'has("message")' >/dev/null 2>&1; then
  # Notification hook
  NOTIFICATION_TYPE=$(echo "$INPUT" | jq -r '.notification_type // ""')

  # Skip idle_prompt notifications
  if [[ "$NOTIFICATION_TYPE" == "idle_prompt" ]]; then
    echo "Skipping idle_prompt notification" >&2
    exit 0
  fi

  TITLE=$(echo "$INPUT" | jq -r '.title // "Claude Code"')
  MESSAGE=$(echo "$INPUT" | jq -r '.message // "Claude Code notification"')
  ICON="🔔"
  COLOR="warning"
else
  # Likely Stop hook
  STOP_HOOK_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // false')

  # For Stop hook, create a custom message
  TITLE="Claude Code - Task Completed"
  MESSAGE="Task has been completed successfully"
  ICON="✅"
  COLOR="good"

  # If stop_hook_active is true, we might want to skip notification to avoid loops
  if [[ "$STOP_HOOK_ACTIVE" == "true" ]]; then
    echo "Skipping notification as stop_hook_active is true" >&2
    exit 0
  fi
fi

# Add timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Create Slack payload with different styling based on hook type
PAYLOAD=$(jq -n \
  --arg title "$ICON $TITLE" \
  --arg message "$MESSAGE" \
  --arg time "$TIMESTAMP" \
  --arg color "$COLOR" \
  '{
    "text": $title,
    "attachments": [{
      "color": $color,
      "fields": [
        {
          "title": "Message:",
          "value": $message,
          "short": false
        },
        {
          "title": "Time:",
          "value": $time,
          "short": true
        }
      ]
    }]
  }')

# Send to Slack
HTTP_CODE=$(curl -X POST \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" \
  "$WEBHOOK_URL" \
  -s -o /dev/null -w "%{http_code}")

if [[ "$HTTP_CODE" != "200" ]]; then
  echo "Error: Slack returned $HTTP_CODE" >&2
  exit 1
fi

echo "Notification sent to Slack: HTTP $HTTP_CODE"
