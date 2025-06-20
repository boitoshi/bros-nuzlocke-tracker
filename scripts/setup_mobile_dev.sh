#!/bin/bash
echo "🚀 Mobile development setup starting..."

# Tailscale setup
echo "📡 Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

# Tailscale起動（認証キーは後で設定）
echo "🔐 Starting Tailscale (you'll need to authenticate)..."
sudo tailscale up

# SSH setup  
echo "🔑 Setting up SSH server..."
sudo apt update
sudo apt install openssh-server -y

# SSH設定を調整（セキュリティ向上）
sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# SSHサービス起動
sudo service ssh start
sudo service ssh enable

# 現在のユーザーのSSHディレクトリ作成
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Tailscale接続情報を取得
echo "📱 Getting connection info..."
TAILSCALE_IP=$(tailscale ip -4)
HOSTNAME=$(hostname)
USERNAME=$(whoami)

echo "✅ Setup complete!"
echo ""
echo "📋 Connection Information:"
echo "   Tailscale IP: $TAILSCALE_IP"
echo "   SSH Command:  ssh $USERNAME@$TAILSCALE_IP"
echo "   Port:         22"
echo ""
echo "🔧 Next steps:"
echo "1. Set up SSH key authentication (recommended)"
echo "2. Configure Terminas with the connection info above"
echo "3. Test connection from your mobile device"
