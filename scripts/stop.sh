#!/bin/bash

# Script para parar a aplicação

echo "⏹️  Parando containers..."

docker-compose down

echo "✅ Containers parados!"
echo ""
echo "Para remover volumes (apagar dados): docker-compose down -v"

