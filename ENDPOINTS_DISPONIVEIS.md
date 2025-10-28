# Endpoints Disponíveis

## Acesse no navegador

### 1. Página Inicial - Raiz (nova!)
**URL**: http://localhost:8080/

**Resposta**:
```json
{
    "message": "Spring Boot API funcionando!",
    "version": "1.0.0",
    "status": "UP",
    "endpoints": {
        "health": "/actuator/health",
        "produtos": "/api/produtos"
    }
}
```

### 2. Health Check
**URL**: http://localhost:8080/actuator/health

**Resposta**:
```json
{
    "status": "UP",
    "timestamp": "2025-10-28T22:49:54"
}
```

### 3. Listar Produtos
**URL**: http://localhost:8080/api/produtos

**Método**: GET

**Resposta**:
```json
[
    {
        "id": 1,
        "nome": "Mouse Logitech",
        "preco": 150.0,
        "descricao": "Mouse wireless",
        "estoque": 50,
        "dataCriacao": "2025-10-28T22:43:03.567975"
    }
]
```

### 4. Criar Produto
**URL**: http://localhost:8080/api/produtos

**Método**: POST

**Body** (JSON):
```json
{
    "nome": "Produto Teste",
    "preco": 99.99,
    "descricao": "Descrição do produto",
    "estoque": 100
}
```

### 5. Buscar Produto por ID
**URL**: http://localhost:8080/api/produtos/{id}

**Método**: GET

**Exemplo**: http://localhost:8080/api/produtos/1

### 6. Atualizar Produto
**URL**: http://localhost:8080/api/produtos/{id}

**Método**: PUT

**Body** (JSON):
```json
{
    "nome": "Produto Atualizado",
    "preco": 199.99,
    "descricao": "Nova descrição",
    "estoque": 50
}
```

### 7. Deletar Produto
**URL**: http://localhost:8080/api/produtos/{id}

**Método**: DELETE

## Testando via cURL

### Criar produto
```bash
curl -X POST http://localhost:8080/api/produtos \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Teclado Mecânico",
    "preco": 450.00,
    "descricao": "Teclado RGB",
    "estoque": 30
  }'
```

### Listar todos
```bash
curl http://localhost:8080/api/produtos
```

### Buscar por ID
```bash
curl http://localhost:8080/api/produtos/1
```

### Atualizar
```bash
curl -X PUT http://localhost:8080/api/produtos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Mouse Logitech Pro",
    "preco": 200.00,
    "descricao": "Mouse gaming",
    "estoque": 40
  }'
```

### Deletar
```bash
curl -X DELETE http://localhost:8080/api/produtos/1
```

## No navegador

Apenas acesse:
- **http://localhost:8080/** → Ver informações da API
- **http://localhost:8080/api/produtos** → Ver lista de produtos

