#!/bin/bash

# Script para iniciar a aplicação Spring Boot com Docker

echo "🚀 Iniciando Spring Boot com Docker Compose..."

# Verifica se docker e docker-compose estão instalados
if ! command -v docker &> /dev/null; then
    echo "❌ Docker não está instalado. Instale primeiro."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose não está instalado. Instale primeiro."
    exit 1
fi

# Para containers existentes
echo "⏹️  Parando containers existentes..."
docker-compose down

# Build e up
echo "🏗️  Construindo e iniciando containers..."
docker-compose up -d --build

# Aguarda containers subirem
echo "⏳ Aguardando containers ficarem prontos..."
sleep 10

# Verifica status
echo "📊 Verificando status dos containers..."
docker-compose ps

# Testa health check
echo "🔍 Testando health check..."
sleep 5
curl -s http://localhost:8080/actuator/health | jq . || echo "⚠️  Health check ainda não está respondendo (pode levar mais alguns segundos)"

echo ""
echo "✅ Aplicação iniciada!"
echo "📍 API disponível em: http://localhost:8080"
echo "📍 PostgreSQL disponível em: localhost:5432"
echo ""
echo "Para ver logs: docker-compose logs -f app"
echo "Para parar: docker-compose down"

