#!/bin/bash

# Script para visualizar logs

SERVICE=${1:-app}

echo "📋 Logs do serviço: $SERVICE"
echo ""

docker-compose logs -f $SERVICE

