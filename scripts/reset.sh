#!/bin/bash

# Script para resetar completamente a aplicação

echo "🔄 Resetando aplicação..."

# Para e remove containers e volumes
echo "🗑️  Removendo containers e volumes..."
docker-compose down -v

# Remove imagens se necessário
read -p "Deseja remover as imagens também? (s/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    echo "🗑️  Removendo imagens..."
    docker-compose down --rmi all
fi

# Rebuild e start
echo "🏗️  Reconstruindo e iniciando..."
docker-compose up -d --build

# Aguarda containers subirem
echo "⏳ Aguardando containers ficarem prontos..."
sleep 15

# Verifica status
echo "📊 Verificando status..."
docker-compose ps

echo "✅ Aplicação resetada e reiniciada!"

