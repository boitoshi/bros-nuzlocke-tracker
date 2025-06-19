#!/bin/bash
echo "🔑 SSH Key Authentication Setup"
echo ""

# SSH鍵ペア生成（Ed25519推奨）
echo "Generating SSH key pair..."
ssh-keygen -t ed25519 -f ~/.ssh/terminas_key -N ""

echo ""
echo "📋 Your PUBLIC key (add this to Terminas):"
echo "======================================================"
cat ~/.ssh/terminas_key.pub
echo "======================================================"
echo ""

# authorized_keysに追加
cat ~/.ssh/terminas_key.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

echo "✅ SSH key setup complete!"
echo ""
echo "📱 For Terminas app:"
echo "1. Copy the PUBLIC key above"
echo "2. Add it to your Terminas SSH key settings"
echo "3. Use the PRIVATE key for authentication"
echo ""
echo "🔒 Your PRIVATE key location: ~/.ssh/terminas_key"
