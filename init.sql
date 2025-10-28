-- Script de inicialização do banco de dados
-- Este arquivo é executado automaticamente na primeira execução do container PostgreSQL

-- Cria o banco de dados se não existir
CREATE DATABASE IF NOT EXISTS springdb;

-- Conecta ao banco
\c springdb;

-- Exemplo: Criar tabelas customizadas (opcional)
-- As tabelas serão criadas automaticamente pelo JPA/Hibernate

-- Criar extensão para UUIDs se necessário
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Inserir dados de exemplo (opcional)
-- Podem ser adicionados aqui, mas é melhor usar fixtures via código

