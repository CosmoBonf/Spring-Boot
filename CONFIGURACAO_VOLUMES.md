# Configuração de Volumes

## Localização dos Dados

Os dados do PostgreSQL são salvos diretamente no sistema de arquivos em:

```
/home/cf/docker/postgres-data/
```

## Vantagens desta Configuração

1. **Acesso Direto**: Você pode ver e manipular os dados diretamente no sistema de arquivos
2. **Backup Simples**: Basta copiar a pasta `/home/cf/docker/postgres-data/`
3. **Sem Gestão de Volumes Docker**: Não precisa usar comandos de volume do Docker
4. **Portabilidade**: Os dados ficam em um local conhecido e fixo

## Como Funciona

O `docker-compose.yml` usa um bind mount em vez de volume Docker:

```yaml
volumes:
  - /home/cf/docker/postgres-data:/var/lib/postgresql/data
```

Isso mapeia diretamente a pasta do host para dentro do container.

## Limpar Dados

Se quiser limpar os dados do banco:

```bash
# Parar containers
docker-compose down

# Remover pasta de dados
rm -rf /home/cf/docker/postgres-data/*

# Reiniciar
docker-compose up -d
```

## Backup

Para fazer backup:

```bash
# Backups simples - copiar a pasta
cp -r /home/cf/docker/postgres-data /home/cf/docker/postgres-data-backup-$(date +%Y%m%d)

# Ou usar pg_dump
docker exec spring-postgres pg_dump -U postgres springdb > backup.sql
```

## Restaurar Backup

```bash
# Se tiver pasta de backup
rm -rf /home/cf/docker/postgres-data/*
cp -r /home/cf/docker/postgres-data-backup-YYYYMMDD/* /home/cf/docker/postgres-data/

# Ou restaurar dump SQL
docker exec -i spring-postgres psql -U postgres springdb < backup.sql
```

## Observação

A pasta `/home/cf/docker/postgres-data/` **não** é removida automaticamente ao fazer `docker-compose down`. Os dados persistem mesmo depois de parar os containers.

Para remover completamente os dados:

```bash
docker-compose down
rm -rf /home/cf/docker/postgres-data/
```

