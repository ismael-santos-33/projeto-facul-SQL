create database supermercado;

use supermercado;


-- Desativa verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 0;

-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS supermercado;
USE supermercado;

-- Tabela de Fornecedores
DROP TABLE IF EXISTS tbl_fornecedores;
CREATE TABLE tbl_fornecedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    produtos_fornecidos TEXT,
    valor_frete DECIMAL(5,2)
);

-- Tabela de E-mail dos Fornecedores
DROP TABLE IF EXISTS tbl_email_fornecedor;
CREATE TABLE tbl_email_fornecedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    tbl_fornecedores_id INT,
    FOREIGN KEY (tbl_fornecedores_id) REFERENCES tbl_fornecedores(id) ON DELETE CASCADE
);

-- Tabela de Telefone dos Fornecedores
DROP TABLE IF EXISTS tbl_telefone_fornecedor;
CREATE TABLE tbl_telefone_fornecedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(15) NOT NULL,
    tbl_fornecedores_id INT,
    FOREIGN KEY (tbl_fornecedores_id) REFERENCES tbl_fornecedores(id) ON DELETE CASCADE
);

-- Tabela de Endereço dos Fornecedores
DROP TABLE IF EXISTS tbl_endereco_fornecedor;
CREATE TABLE tbl_endereco_fornecedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cidade VARCHAR(45),
    logradouro VARCHAR(45),
    bairro VARCHAR(45),
    cep VARCHAR(10),
    pais VARCHAR(45),
    estado VARCHAR(45),
    tbl_fornecedores_id INT,
    FOREIGN KEY (tbl_fornecedores_id) REFERENCES tbl_fornecedores(id) ON DELETE CASCADE
);

-- Tabela de Produtos
DROP TABLE IF EXISTS tbl_produtos;
CREATE TABLE tbl_produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    valor_compra DECIMAL(10,2),
    valor_venda DECIMAL(10,2),
    data_validade DATE,
    codigo_de_barras VARCHAR(12),
    descricao VARCHAR(255),
    preco DECIMAL(10,2),
    qntd_estoque INT,
    categoria VARCHAR(45),
    tbl_fornecedores_id INT,
    FOREIGN KEY (tbl_fornecedores_id) REFERENCES tbl_fornecedores(id) ON DELETE CASCADE
);

-- Tabela de Clientes
DROP TABLE IF EXISTS tbl_clientes;
CREATE TABLE tbl_clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_cadastro DATE,
    historico_compras TEXT,
    cpf VARCHAR(15) UNIQUE
);

-- Tabela de Telefone dos Clientes
DROP TABLE IF EXISTS tbl_telefone_clientes;
CREATE TABLE tbl_telefone_clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(15),
    tbl_clientes_id INT,
    FOREIGN KEY (tbl_clientes_id) REFERENCES tbl_clientes(id) ON DELETE CASCADE
);

-- Tabela de E-mail dos Clientes
DROP TABLE IF EXISTS tbl_email_clientes;
CREATE TABLE tbl_email_clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255),
    tbl_clientes_id INT,
    FOREIGN KEY (tbl_clientes_id) REFERENCES tbl_clientes(id) ON DELETE CASCADE
);

-- Tabela de Endereço dos Clientes
DROP TABLE IF EXISTS tbl_endereco_clientes;
CREATE TABLE tbl_endereco_clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    logradouro VARCHAR(45),
    cidade VARCHAR(45),
    estado VARCHAR(45),
    pais VARCHAR(45),
    bairro VARCHAR(45),
    cep VARCHAR(10),
    tbl_clientes_id INT,
    FOREIGN KEY (tbl_clientes_id) REFERENCES tbl_clientes(id) ON DELETE CASCADE
);

-- Tabela de Pedidos
DROP TABLE IF EXISTS tbl_pedidos;
CREATE TABLE tbl_pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status_pedido ENUM('pendente', 'processando', 'enviado', 'entregue', 'cancelado', 'devolvido'),
    valor_total DECIMAL(10,2),
    data_pedido DATE,
    data_entrega DATE,
    numero_pedido INT,
    tbl_clientes_id INT,
    tbl_colaboradores_id INT,
    FOREIGN KEY (tbl_clientes_id) REFERENCES tbl_clientes(id) ON DELETE CASCADE,
    FOREIGN KEY (tbl_colaboradores_id) REFERENCES tbl_colaboradores(id) ON DELETE SET NULL
);

-- Tabela de Colaboradores
DROP TABLE IF EXISTS tbl_colaboradores;
CREATE TABLE tbl_colaboradores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    salario DECIMAL(8,2),
    departamento VARCHAR(50),
    data_contratacao DATE,
    cargo VARCHAR(50),
    numero_registro INT UNIQUE
);

-- Tabela de Vendas
DROP TABLE IF EXISTS tbl_vendas;
CREATE TABLE tbl_vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status_vendas ENUM('iniciada', 'pendente', 'confirmada', 'cancelada', 'completa', 'reembolsada'),
    data_hora DATETIME,
    valor_total DECIMAL(10,2),
    tbl_colaboradores_id INT,
    FOREIGN KEY (tbl_colaboradores_id) REFERENCES tbl_colaboradores(id) ON DELETE SET NULL
);

-- Tabela de Itens Vendidos
DROP TABLE IF EXISTS tbl_itens_vendas;
CREATE TABLE tbl_itens_vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    preco_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    quantidade INT,
    tbl_pedidos_id INT,
    tbl_vendas_id INT,
    FOREIGN KEY (tbl_pedidos_id) REFERENCES tbl_pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (tbl_vendas_id) REFERENCES tbl_vendas(id) ON DELETE CASCADE
);

-- Tabela de Pagamentos
DROP TABLE IF EXISTS tbl_pagamentos;
CREATE TABLE tbl_pagamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status_pagamentos ENUM('pendente', 'pago', 'falhou'),
    valor_pago DECIMAL(10,2),
    metodo_pagamento ENUM('dinheiro', 'cartao_credito', 'cartao_debito', 'pix', 'vale_refeicao'),
    data_pagamento DATETIME,
    tbl_vendas_id INT,
    FOREIGN KEY (tbl_vendas_id) REFERENCES tbl_vendas(id) ON DELETE CASCADE
);

-- Tabela de Devoluções
DROP TABLE IF EXISTS tbl_devolucoes;
CREATE TABLE tbl_devolucoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    motivo_devolucao TEXT,
    qntd_devolvida INT,
    status_devolucao ENUM('solicitada', 'em análise', 'aprovada', 'rejeitada', 'concluída', 'produto recebido'),
    valor_estornado DECIMAL(10,2),
    data_devolucao DATE,
    tbl_vendas_id INT,
    tbl_colaboradores_id INT,
    FOREIGN KEY (tbl_vendas_id) REFERENCES tbl_vendas(id) ON DELETE CASCADE,
    FOREIGN KEY (tbl_colaboradores_id) REFERENCES tbl_colaboradores(id) ON DELETE SET NULL
);

-- Tabela de Estoque
DROP TABLE IF EXISTS tbl_estoque;
CREATE TABLE tbl_estoque (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_entrada DATE,
    qntd_disponivel INT,
    data_saida DATE,
    localizacao_deposito VARCHAR(50),
    tbl_produtos_id INT,
    tbl_fornecedores_id INT,
    FOREIGN KEY (tbl_produtos_id) REFERENCES tbl_produtos(id) ON DELETE CASCADE,
    FOREIGN KEY (tbl_fornecedores_id) REFERENCES tbl_fornecedores(id) ON DELETE CASCADE
);

-- Reativar verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;
