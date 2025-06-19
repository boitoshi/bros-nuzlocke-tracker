#!/bin/bash
echo "🚀 Starting Rails development server for mobile access..."

# Tailscale IPを取得
TAILSCALE_IP=$(tailscale ip -4)

if [ -z "$TAILSCALE_IP" ]; then
    echo "❌ Tailscale not connected. Please run './setup_mobile_dev.sh' first"
    exit 1
fi

echo "📱 Server will be accessible at: http://$TAILSCALE_IP:3000"
echo "🌐 Starting Rails server..."
echo ""

# Rails server を全IPからアクセス可能にして起動
bin/rails server -b 0.0.0.0 -p 3000
