#!/bin/sh
# Substitute environment variables into alertmanager config, then start alertmanager

set -e

# Default webhook URL if not set
SLACK_WEBHOOK_URL="${SLACK_WEBHOOK_URL:-https://hooks.slack.com/services/REPLACE/ME}"

# Substitute the webhook URL into config
sed "s|SLACK_WEBHOOK_URL_PLACEHOLDER|${SLACK_WEBHOOK_URL}|g" \
  /etc/alertmanager/alertmanager.yml.orig > /etc/alertmanager/alertmanager.yml

# Start alertmanager with the generated config
exec /bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml "$@"
