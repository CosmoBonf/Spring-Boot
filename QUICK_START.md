# 🚀 Início Rápido

## Execução Rápida (1 minuto)

### 1. Subir os containers
```bash
docker-compose up -d
```

### 2. Verificar se está funcionando
```bash
# Verificar status
docker-compose ps

# Ver logs da aplicação
docker-compose logs -f app
```

### 3. Testar a API
```bash
# Health check
curl http://localhost:8080/actuator/health

# Criar produto
curl -X POST http://localhost:8080/api/produtos \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Produto Teste",
    "preco": 100.00,
    "descricao": "Descrição do produto",
    "estoque": 50
  }'

# Listar produtos
curl http://localhost:8080/api/produtos
```

## ⏹️ Parar os containers

```bash
docker-compose down
```

## 🔄 Reiniciar tudo do zero

```bash
# Remove volumes (apaga banco de dados)
docker-compose down -v

# Rebuild e start
docker-compose up -d --build
```

## 🔧 Comandos Essenciais

| Comando | Descrição |
|---------|-----------|
| `docker-compose up -d` | Inicia containers em background |
| `docker-compose down` | Para e remove containers |
| `docker-compose logs -f app` | Ver logs da aplicação |
| `docker-compose ps` | Status dos containers |
| `docker-compose restart app` | Reinicia apenas a aplicação |
| `docker exec -it spring-postgres psql -U postgres` | Acesso ao PostgreSQL |

## 🌐 Acessos

- **Aplicação**: http://localhost:8080
- **API**: http://localhost:8080/api/produtos
- **Health**: http://localhost:8080/actuator/health
- **PostgreSQL**: localhost:5432

## 📝 Ver dados no banco

```bash
# Entrar no container do PostgreSQL
docker exec -it spring-postgres psql -U postgres -d springdb

# Ver tabelas
\dt

# Ver produtos
SELECT * FROM produtos;

# Sair
\q
```

## ❓ Problemas Comuns

### Porta já em uso
```bash
# Editar docker-compose.yml e alterar APP_PORT e DB_PORT
```

### Container não sobe
```bash
# Ver logs detalhados
docker-compose logs app
docker-compose logs postgres
```

### Rebuild completo
```bash
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d
```

