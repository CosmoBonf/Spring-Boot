# Spring Boot com Docker e PostgreSQL

Aplicação Spring Boot moderna com Docker, Docker Compose e PostgreSQL, demonstrando as melhores práticas de desenvolvimento Java.

## 🚀 Tecnologias

- Java 17
- Spring Boot 3.2.0
- Spring Data JPA
- PostgreSQL 16
- Docker & Docker Compose
- Lombok
- Maven

## 📋 Pré-requisitos

- Docker (versão 20.10+)
- Docker Compose (versão 2.0+)
- Java 17+ (opcional, apenas para desenvolvimento local)
- Maven 3.9+ (opcional, apenas para desenvolvimento local)

## 🏃 Como Executar

### Opção 1: Docker (Recomendado)

1. **Clone o repositório**:
```bash
cd Spring-Boot
```

2. **Inicie os containers**:
```bash
docker-compose up -d
```

Isso vai:
- Construir a imagem da aplicação
- Iniciar o container PostgreSQL
- Iniciar o container Spring Boot
- Criar as tabelas automaticamente

3. **Verifique os logs**:
```bash
docker-compose logs -f app
```

4. **Acesse a aplicação**:
```
http://localhost:8080
```

### Opção 2: Desenvolvimento Local

1. **Instale o PostgreSQL**:
```bash
# Ubuntu/Debian
sudo apt-get install postgresql postgresql-contrib

# Criar banco de dados
sudo -u postgres psql
CREATE DATABASE springdb;
```

2. **Execute a aplicação**:
```bash
mvn clean package
java -jar target/spring-boot-docker-1.0.0-SNAPSHOT.jar
```

## 🧪 Testando a API

### Criar um Produto
```bash
curl -X POST http://localhost:8080/api/produtos \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Notebook Dell",
    "preco": 3500.00,
    "descricao": "Notebook Dell Inspiron",
    "estoque": 10
  }'
```

### Listar Produtos
```bash
curl http://localhost:8080/api/produtos
```

### Buscar por ID
```bash
curl http://localhost:8080/api/produtos/1
```

### Buscar por Nome
```bash
curl http://localhost:8080/api/produtos/buscar?nome=Dell
```

### Atualizar Produto
```bash
curl -X PUT http://localhost:8080/api/produtos/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "Notebook Dell Atualizado",
    "preco": 3800.00,
    "descricao": "Nova descrição",
    "estoque": 8
  }'
```

### Deletar Produto
```bash
curl -X DELETE http://localhost:8080/api/produtos/1
```

### Health Check
```bash
curl http://localhost:8080/actuator/health
```

## 📁 Estrutura do Projeto

```
.
├── src/
│   └── main/
│       ├── java/com/example/springboot/
│       │   ├── SpringBootApplication.java    # Classe principal
│       │   ├── controller/                   # REST Controllers
│       │   │   ├── ProdutoController.java
│       │   │   └── HealthController.java
│       │   ├── service/                      # Lógica de negócio
│       │   │   └── ProdutoService.java
│       │   ├── repository/                    # Repositórios JPA
│       │   │   └── ProdutoRepository.java
│       │   └── model/                         # Entidades
│       │       └── Produto.java
│       └── resources/
│           └── application.properties         # Configurações
├── pom.xml                                    # Dependências Maven
├── Dockerfile                                 # Imagem Docker
├── docker-compose.yml                         # Orquestração
├── .dockerignore                              # Arquivos ignorados
├── init.sql                                   # Script inicial BD
├── README.md                                  # Este arquivo
└── COMO_FUNCIONA.md                          # Documentação detalhada
```

## 🔧 Comandos Úteis

### Docker
```bash
# Iniciar containers
docker-compose up -d

# Parar containers
docker-compose down

# Ver logs
docker-compose logs -f

# Rebuild forçado
docker-compose build --no-cache
docker-compose up -d

# Entrar no container do PostgreSQL
docker exec -it spring-postgres psql -U postgres -d springdb

# Ver status dos containers
docker-compose ps
```

### Banco de Dados
```bash
# Acessar PostgreSQL via Docker
docker exec -it spring-postgres psql -U postgres -d springdb

# Listar tabelas
\dt

# Ver dados da tabela produtos
SELECT * FROM produtos;

# Sair do psql
\q
```

## 📝 Configuração

### Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto para personalizar:

```env
DB_NAME=springdb
DB_USER=postgres
DB_PASSWORD=postgres
DB_PORT=5432
APP_PORT=8080
```

### Configuração PostgreSQL

As configurações estão em `docker-compose.yml`:
- Porta: 5432
- Database: springdb (padrão)
- Usuário: postgres (padrão)
- Senha: postgres (padrão)

## 🐛 Troubleshooting

### Container não inicia
```bash
# Ver logs do container
docker-compose logs app

# Verificar healthcheck
docker inspect spring-app | grep Health -A 10
```

### Erro de conexão com banco
```bash
# Verificar se PostgreSQL está rodando
docker-compose ps

# Testar conexão
docker exec -it spring-postgres pg_isready
```

### Rebuild completo
```bash
# Parar e remover tudo
docker-compose down -v

# Rebuild
docker-compose build --no-cache
docker-compose up -d
```

## 📖 Documentação Adicional

Consulte `COMO_FUNCIONA.md` para entender detalhadamente:
- Arquitetura do sistema
- Fluxo de dados
- Configurações avançadas
- Otimizações de performance

## 🔐 Segurança

- Container executando com usuário não-root
- Network isolation entre containers
- Healthchecks configurados
- Multi-stage build para menor superfície de ataque

## 📊 Monitoramento

- Healthcheck endpoint: `GET /actuator/health`
- Logs SQL habilitados em desenvolvimento
- Docker stats disponível

## 🤝 Contribuindo

1. Fork o projeto
2. Crie sua feature branch
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 Licença

Este projeto é open source e está disponível sob a licença MIT.

## 🆘 Suporte

Para problemas ou dúvidas:
1. Verifique a seção Troubleshooting
2. Consulte os logs: `docker-compose logs`
3. Verifique a documentação em `COMO_FUNCIONA.md`
