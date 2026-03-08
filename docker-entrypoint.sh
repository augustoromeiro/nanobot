#!/bin/sh
set -eu

mkdir -p /root/.nanobot/workspace
mkdir -p /root/.nanobot/memory
mkdir -p /root/.nanobot/cron
mkdir -p /root/.nanobot/media
mkdir -p /root/.codex

if [ ! -f /root/.nanobot/config.json ]; then
  cat > /root/.nanobot/config.json <<EOF
{
  "agents": {
    "defaults": {
      "workspace": "/root/.nanobot/workspace",
      "model": "openai-codex/gpt-5.4"
    }
  },
  "providers": {{
    "openai": {
      "apiKey": "dummy"
    },
    "openaiCodex": {
      "apiKey": "dummy",
      "apiBase": null,
      "extraHeaders": null
    }
  },
  "gateway": {
    "host": "0.0.0.0",
    "port": 18790
  }
}
EOF
fi

exec nanobot gateway --config /root/.nanobot/config.json
