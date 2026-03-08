#!/bin/sh
set -eu

mkdir -p /root/.nanobot
mkdir -p /root/.nanobot/workspace
mkdir -p /root/.nanobot/memory
mkdir -p /root/.nanobot/cron
mkdir -p /root/.nanobot/media

MODEL="${NANOBOT_MODEL:-openai/gpt-4o-mini}"
PORT="${NANOBOT_PORT:-18790}"

if [ ! -f /root/.nanobot/config.json ]; then
  if [ -z "${OPENAI_API_KEY:-}" ]; then
    echo "Erro: OPENAI_API_KEY não definida."
    exit 1
  fi

  cat > /root/.nanobot/config.json <<EOF
{
  "providers": {
    "openai": {
      "apiKey": "${OPENAI_API_KEY}"
    }
  },
  "agents": {
    "defaults": {
      "model": "${MODEL}",
      "workspace": "/root/.nanobot/workspace"
    }
  },
  "gateway": {
    "port": ${PORT}
  }
}
EOF

  echo "config.json criado."
else
  echo "config.json já existe. Mantendo."
fi

echo "Iniciando nanobot gateway na porta ${PORT} com modelo ${MODEL}..."
exec nanobot gateway --config /root/.nanobot/config.json
