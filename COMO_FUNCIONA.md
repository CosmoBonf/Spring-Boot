# Como Funciona - Spring Boot com Docker e PostgreSQL

## Visão Geral

Este projeto é uma aplicação Spring Boot moderna, containerizada com Docker e Docker Compose, utilizando PostgreSQL como banco de dados. O projeto demonstra as melhores práticas de desenvolvimento Java com Spring Framework.

## Arquitetura

### Componentes Principais

```
Spring Boot Application
├── Controller Layer (REST API)
│   └── ProdutoController
├── Service Layer (Lógica de Negócio)
│   └── ProdutoService
├── Repository Layer (Persistência)
│   └── ProdutoRepository
└── Model Layer (Entidades)
    └── Produto
```

### Tecnologias Utilizadas

- **Java 17**: Linguagem de programação
- **Spring Boot 3.2.0**: Framework Java
- **Spring Data JPA**: Persistência e abstração de banco de dados
- **PostgreSQL 16**: Banco de dados relacional
- **Docker & Docker Compose**: Containerização
- **Lombok**: Redução de boilerplate
- **Maven**: Gerenciamento de dependências

## Estrutura do Projeto

```
.
├── src/
│   └── main/
│       ├── java/com/example/springboot/
│       │   ├── SpringBootApplication.java    # Classe principal
│       │   ├── controller/                   # Camada de controle REST
│       │   │   ├── ProdutoController.java
│       │   │   └── HealthController.java
│       │   ├── service/                       # Camada de serviço
│       │   │   └── ProdutoService.java
│       │   ├── repository/                    # Camada de repositório
│       │   │   └── ProdutoRepository.java
│       │   └── model/                         # Entidades
│       │       └── Produto.java
│       └── resources/
│           └── application.properties         # Configurações
├── pom.xml                                    # Dependências Maven
├── Dockerfile                                 # Imagem Docker da aplicação
├── docker-compose.yml                         # Orquestração dos containers
├── init.sql                                   # Script de inicialização do BD
└── .dockerignore                              # Arquivos ignorados no build
```

## Como Funciona - Detalhamento

### 1. Application.properties

Define as configurações da aplicação:
- **Porta**: 8080
- **Banco de dados**: PostgreSQL
- **JPA/Hibernate**: Auto-update de schema (`ddl-auto=update`)
- **Logging**: SQL queries e debugging

### 2. Docker Multi-Stage Build

O Dockerfile utiliza build em dois estágios:

**Stage 1: Build**
```dockerfile
FROM maven:3.9-eclipse-temurin-17
# Compila a aplicação e cria o JAR
```

**Stage 2: Runtime**
```dockerfile
FROM eclipse-temurin:17-jre-alpine
# Imagem final otimizada apenas com JRE
```

Benefícios:
- Imagem final menor (~200MB vs ~600MB)
- Mais seguro (sem Maven na imagem de produção)
- Execução mais rápida

### 3. Docker Compose

Orchestração de dois serviços:

**PostgreSQL Container:**
- Imagem: `postgres:16-alpine`
- Porta: 5432
- Volume persistente: `postgres-data`
- Healthcheck para garantir disponibilidade

**Spring Boot Container:**
- Build da aplicação
- Dependência: espera PostgreSQL ficar saudável
- Porta: 8080
- Healthcheck customizado

### 4. Camadas da Aplicação

#### Model Layer (`Produto`)
```java
@Entity
@Table(name = "produtos")
public class Produto {
    - id, nome, preco, descricao, estoque
    - @PrePersist para data automática
}
```

#### Repository Layer (`ProdutoRepository`)
```java
public interface ProdutoRepository extends JpaRepository<Produto, Long> {
    - Métodos CRUD automáticos
    - Queries customizadas
    - Busca por nome, preço, estoque
}
```

#### Service Layer (`ProdutoService`)
```java
@Service
public class ProdutoService {
    - Lógica de negócio
    - Transações gerenciadas
    - Validações
}
```

#### Controller Layer (`ProdutoController`)
```java
@RestController
@RequestMapping("/api/produtos")
public class ProdutoController {
    - Endpoints REST
    - CRUD completo
    - Filtros e buscas
}
```

## Fluxo de Dados

1. **Cliente** → Faz requisição HTTP
2. **Controller** → Recebe e valida requisição
3. **Service** → Processa lógica de negócio
4. **Repository** → Persiste/consulta no banco
5. **PostgreSQL** → Armazena dados
6. **Response** → Retorna JSON ao cliente

## Endpoints da API

### Produtos

- `GET /api/produtos` - Listar todos
- `GET /api/produtos/{id}` - Buscar por ID
- `POST /api/produtos` - Criar novo
- `PUT /api/produtos/{id}` - Atualizar
- `DELETE /api/produtos/{id}` - Deletar
- `GET /api/produtos/buscar?nome=X` - Buscar por nome
- `GET /api/produtos/preco?precoMin=X&precoMax=Y` - Buscar por faixa de preço
- `GET /api/produtos/estoque` - Buscar produtos em estoque

### Health Check

- `GET /actuator/health` - Status da aplicação

## Persistência com JPA/Hibernate

### Configuração
```properties
spring.jpa.hibernate.ddl-auto=update
```
- Cria/atualiza tabelas automaticamente
- Não deleta dados existentes

### Relacionamento de Entidades
```
Produto (Entidade)
    ↓
@Table(name = "produtos")
    ↓
PostgreSQL (Tabela)
```

### Queries
- **Repository Method Naming**: `findByNomeContainingIgnoreCase`
- **JPQL Custom**: `@Query("SELECT p FROM Produto p...")`
- **Native SQL**: Disponível quando necessário

## Docker Compose - Detalhes

### Networks
```yaml
networks:
  spring-network:
    driver: bridge
```
- Comunicação interna entre containers
- Isolamento de rede

### Volumes
```yaml
volumes:
  postgres-data:
```
- Dados persistentes do PostgreSQL
- Sobrevive ao restart dos containers

### Healthchecks
- PostgreSQL verifica disponibilidade com `pg_isready`
- Spring Boot verifica com wget
- Dependências respeitam healthchecks

## Configuração de Ambiente

### Variáveis de Ambiente

**Docker Compose:**
- `DB_NAME`: Nome do banco (padrão: springdb)
- `DB_USER`: Usuário (padrão: postgres)
- `DB_PASSWORD`: Senha (padrão: postgres)
- `DB_PORT`: Porta do PostgreSQL (padrão: 5432)
- `APP_PORT`: Porta da aplicação (padrão: 8080)

**Spring Boot:**
- `DB_HOST`: Host do PostgreSQL
- Auto-configurado pelo Docker Compose

## Segurança

1. **Non-root user** no container
2. **Healthchecks** para monitoramento
3. **Alpine Linux** (imagem leve e segura)
4. **Multi-stage build** (sem tools de build em produção)
5. **Network isolation** (comunicação interna)

## Performance

### Otimizações

1. **Connection Pooling**: HikariCP (padrão Spring Boot)
2. **Query Optimization**: Índices automáticos nas foreign keys
3. **Lazy Loading**: JPA carrega entidades sob demanda
4. **Cache**: Hibernate L2 cache (configurável)

### Monitoring

- SQL logging habilitado em desenvolvimento
- Healthcheck endpoint para orquestração
- Spring Boot Actuator (pode ser adicionado)

## Próximos Passos

1. Adicionar testes (JUnit, Mockito)
2. Implementar autenticação (Spring Security)
3. Adicionar documentação da API (SpringDoc/Swagger)
4. Configurar CI/CD
5. Adicionar mais entidades e relacionamentos
6. Implementar DTOs para transferência de dados
7. Adicionar tratamento de exceções global
8. Implementar validações mais robustas

