-- 1. Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS atendelab
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE atendelab;

-- 2. Tabela de Usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('admin', 'atendente') DEFAULT 'atendente',
    status ENUM('ativo', 'inativo') DEFAULT 'ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Inserção do Usuário Inicial
INSERT INTO usuarios (nome, email, senha, perfil, status)
VALUES (
    'Administrador',
    'admin@atendelab.com',
    '$2y$10$J9P2kU2BAMZ3TZcuxTsW4e1D/lka8EocYHzvyoOZmCNcWDQz3RuVC',
    'admin',
    'ativo'
);

-- 4. Tabela de Pessoas Atendidas
CREATE TABLE pessoas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    documento VARCHAR(20) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    curso VARCHAR(100),
    periodo VARCHAR(100),
    status VARCHAR(100) DEFAULT 'ativo'
);

-- 5. Tabela de Tipos de Atendimento
CREATE TABLE tipos_atendimentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    status ENUM('ativo', 'inativo') DEFAULT 'ativo'
);

-- 6. Tabela de Atendimentos (Com as chaves estrangeiras)
CREATE TABLE atendimentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pessoa_id INT NOT NULL,
    tipo_atendimento_id INT NOT NULL,
    usuario_id INT NOT NULL,
    data_atendimento DATE NOT NULL,
    hora_atendimento TIME NOT NULL,
    descricao TEXT NOT NULL,
    observacao TEXT,
    status ENUM('aberto', 'em_andamento', 'concluido') DEFAULT 'aberto',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pessoa_id) REFERENCES pessoas(id),
    FOREIGN KEY (tipo_atendimento_id) REFERENCES tipos_atendimentos(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);