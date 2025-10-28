# 📚 Exemplos de Uso da API

## Endpoints Disponíveis

### Base URL
```
http://localhost:8080
```

---

## 1. Health Check

Verifica se a aplicação está rodando.

```bash
curl http://localhost:8080/actuator/health
```

**Resposta:**
```json
{
  "status": "UP",
  "timestamp": "2024-01-15T10:30:00"
}
```

---

## 2. Listar Todos os Produtos

```bash
curl http://localhost:8080/api/produtos
```

**Resposta:**
```json
[
  {
    "id": 1,
    "nome": "Notebook Dell",
    "preco": 3500.00,
    "descricao": "Notebook Dell Inspiron",
    "estoque": 10,
    "dataCriacao": "2024-01-15T10:25:00"
  },
  {
    "id": 2,
    "nome": "Mouse Logitech",
    "preco": 150.00,
    "descricao": "Mouse wireless",
    "estoque": 50,
    "dataCriacao": "2024-01-15T10:26:00"
  }
]
```

---

## 3. Buscar Produto por ID

```bash
curl http://localhost:8080/api/produtos/1
```

**Resposta:**
```json
{
  "id": 1,
  "nome": "Notebook Dell",
  "preco": 3500.00,
  "descricao": "Notebook Dell Inspiron",
  "estoque": 10,
  "dataCriacao": "2024-01-15T10:25:00"
}
```

---

## 4. Criar Novo Produto

```bash
curl -X POST http://localhost:8080/api/produtos \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Teclado Mecânico",
    "preco": 500.00,
    "descricao": "Teclado RGB mecânico",
    "estoque": 25
  }'
```

**Resposta:**
```json
{
  "id": 3,
  "nome": "Teclado Mecânico",
  "preco": 500.00,
  "descricao": "Teclado RGB mecânico",
  "estoque": 25,
  "dataCriacao": "2024-01-15T10:35:00"
}
```

---

## 5. Atualizar Produto

```bash
curl -X PUT http://localhost:8080/api/produtos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Notebook Dell Atualizado",
    "preco": 3800.00,
    "descricao": "Nova descrição do notebook",
    "estoque": 8
  }'
```

**Resposta:**
```json
{
  "id": 1,
  "nome": "Notebook Dell Atualizado",
  "preco": 3800.00,
  "descricao": "Nova descrição do notebook",
  "estoque": 8,
  "dataCriacao": "2024-01-15T10:25:00"
}
```

---

## 6. Deletar Produto

```bash
curl -X DELETE http://localhost:8080/api/produtos/1
```

**Resposta:**
```
Status: 204 No Content
```

---

## 7. Buscar Produtos por Nome

```bash
curl "http://localhost:8080/api/produtos/buscar?nome=dell"
```

**Resposta:**
```json
[
  {
    "id": 1,
    "nome": "Notebook Dell",
    "preco": 3500.00,
    "descricao": "Notebook Dell Inspiron",
    "estoque": 10,
    "dataCriacao": "2024-01-15T10:25:00"
  }
]
```

---

## 8. Buscar Produtos por Faixa de Preço

```bash
curl "http://localhost:8080/api/produtos/preco?precoMin=100&precoMax=500"
```

**Resposta:**
```json
[
  {
    "id": 2,
    "nome": "Mouse Logitech",
    "preco": 150.00,
    "descricao": "Mouse wireless",
    "estoque": 50,
    "dataCriacao": "2024-01-15T10:26:00"
  },
  {
    "id": 3,
    "nome": "Teclado Mecânico",
    "preco": 500.00,
    "descricao": "Teclado RGB mecânico",
    "estoque": 25,
    "dataCriacao": "2024-01-15T10:35:00"
  }
]
```

---

## 9. Buscar Produtos em Estoque

```bash
curl http://localhost:8080/api/produtos/estoque
```

**Resposta:**
```json
[
  {
    "id": 1,
    "nome": "Notebook Dell",
    "preco": 3500.00,
    "descricao": "Notebook Dell Inspiron",
    "estoque": 10,
    "dataCriacao": "2024-01-15T10:25:00"
  },
  {
    "id": 2,
    "nome": "Mouse Logitech",
    "preco": 150.00,
    "descricao": "Mouse wireless",
    "estoque": 50,
    "dataCriacao": "2024-01-15T10:26:00"
  }
]
```

---

## Testando com ferramentas visuais

### Postman
1. Importar a collection (se disponível)
2. Configurar variável `baseUrl` como `http://localhost:8080`
3. Executar requisições

### Insomnia
1. Criar workspace
2. Configurar base URL: `http://localhost:8080`
3. Adicionar requisições conforme exemplos acima

### Browser
Apenas para GET requests:
```bash
# Abrir no navegador
http://localhost:8080/actuator/health
http://localhost:8080/api/produtos
```

---

## Tratamento de Erros

### Produto não encontrado (404)
```bash
curl http://localhost:8080/api/produtos/999
```
**Resposta:**
```
Status: 404 Not Found
```

### Erro de validação (400)
```bash
# Enviando dados inválidos
curl -X POST http://localhost:8080/api/produtos \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "",
    "preco": -100,
    "estoque": -5
  }'
```
**Resposta:**
```
Status: 400 Bad Request
```

---

## Headers Importantes

### Content-Type
Para requisições POST e PUT:
```
Content-Type: application/json
```

### Accept
Para especificar o formato de resposta:
```
Accept: application/json
```

---

## Formato de Data

As datas são retornadas no formato ISO 8601:
```json
"dataCriacao": "2024-01-15T10:25:00"
```

---

## Paginação (Futuro)

Quando implementado:
```bash
curl "http://localhost:8080/api/produtos?page=0&size=10&sort=nome,asc"
```

---

## Filtering e Sorting (Futuro)

```bash
# Ordenar por preço (crescente)
curl "http://localhost:8080/api/produtos?sort=preco,asc"

# Filtrar e ordenar
curl "http://localhost:8080/api/produtos?nome=notebook&sort=nome,desc"
```

