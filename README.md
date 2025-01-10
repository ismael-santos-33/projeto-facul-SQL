# Levantamento de Requisitos

**Entrevista com Stakeholder e Evidenciação das Informações Obtidas.**

**Aluno**: Franciel Marques Fagundes  
**Disciplina**: Database Modeling & SQL

---

### 1. Quais informações devem ser armazenadas sobre os clientes?
**Resposta**: Nome completo, CPF, endereço, telefone, e-mail, histórico de compras, e a data de cadastro no sistema.

### 2. Quais dados são necessários sobre os produtos vendidos?
**Resposta**: Nome do produto, valor de compra, valor de venda, categoria, descrição, código de barras, preço, quantidade em estoque, data de validade (quando aplicável) e o fornecedor de cada produto.

### 3. Quais informações dos colaboradores devem ser armazenadas?
**Resposta**: Nome completo, CPF, cargo, salário, telefone, e-mail, departamento, número de registro e a data de contratação.

### 4. Quais dados dos fornecedores são necessários?
**Resposta**: Nome do fornecedor, CNPJ, telefone, e-mail, endereço, valor do frete e lista de produtos fornecidos.

### 5. Que informações são essenciais para registrar uma venda?
**Resposta**: Data e hora da venda, cliente que realizou a compra, colaborador que processou a venda, valor total, método de pagamento, possíveis descontos e o status da venda.

### 6. Como devemos armazenar os itens de cada venda?
**Resposta**: ID da venda, ID de cada produto, quantidade comprada de cada item, preço unitário de cada produto e o subtotal para cada item da venda.

### 7. Que informações devem ser registradas no controle de estoque?
**Resposta**: Quantidade disponível de cada produto, localização do produto no depósito, e as datas de entrada e saída de mercadorias.

### 8. Quais informações devemos armazenar sobre os pedidos de compra feitos aos fornecedores?
**Resposta**: Fornecedor responsável, número do pedido, data do pedido, data prevista de entrega, valor total do pedido e o status do pedido.

### 9. Que informações são necessárias armazenar para os pagamentos das vendas?
**Resposta**: Método de pagamento, data do pagamento, valor pago, status do pagamento e a associação do pagamento à venda correspondente.

### 10. Como devemos registrar as devoluções feitas pelos clientes?
**Resposta**: ID da venda original, cliente que fez a devolução, produto devolvido, quantidade devolvida, valor devolvido ao cliente, data da devolução, motivo da devolução e o status da devolução.

---
# **Modelo Conceitual.**
![Conceitual](modelo_conceitual.jpg)

---
# **Modelo Lógico.**
![Lógico](modelo_logico.png)

---
# **Código SQL - Tabelas.**
```sql

create database supermercado;

SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS supermercado;

use supermercado;

DROP TABLE IF EXISTS tbl_fornecedores;
CREATE TABLE tbl_fornecedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    produtos_fornecidos TEXT,
    valor_frete DECIMAL(5,2)
);

DROP TABLE IF EXISTS tbl_email_fornecedor;
CREATE TABLE tbl_email_fornecedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    tbl_fornecedores_id INT,
    FOREIGN KEY (tbl_fornecedores_id) REFERENCES tbl_fornecedores(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS tbl_telefone_fornecedor;
CREATE TABLE tbl_telefone_fornecedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(15) NOT NULL,
    tbl_fornecedores_id INT,
    FOREIGN KEY (tbl_fornecedores_id) REFERENCES tbl_fornecedores(id) ON DELETE CASCADE
);

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

DROP TABLE IF EXISTS tbl_clientes;
CREATE TABLE tbl_clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_cadastro DATE,
    historico_compras TEXT,
    cpf VARCHAR(15) UNIQUE
);

DROP TABLE IF EXISTS tbl_telefone_clientes;
CREATE TABLE tbl_telefone_clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero VARCHAR(15),
    tbl_clientes_id INT,
    FOREIGN KEY (tbl_clientes_id) REFERENCES tbl_clientes(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS tbl_email_clientes;
CREATE TABLE tbl_email_clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255),
    tbl_clientes_id INT,
    FOREIGN KEY (tbl_clientes_id) REFERENCES tbl_clientes(id) ON DELETE CASCADE
);

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

DROP TABLE IF EXISTS tbl_vendas;
CREATE TABLE tbl_vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status_vendas ENUM('iniciada', 'pendente', 'confirmada', 'cancelada', 'completa', 'reembolsada'),
    data_hora DATETIME,
    valor_total DECIMAL(10,2),
    tbl_colaboradores_id INT,
    FOREIGN KEY (tbl_colaboradores_id) REFERENCES tbl_colaboradores(id) ON DELETE SET NULL
);

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

SET FOREIGN_KEY_CHECKS = 1;

``` 
---
# **Código SQL - Inserções.**

```sql
use supermercado;


INSERT INTO tbl_fornecedores (nome_fornecedor, cnpj, produtos_fornecidos, valor_frete)
VALUES ('Marques Fornecedora', '12345678901234', 'Palete de arroz, Palete de feijão', 100.00);


INSERT INTO tbl_email_fornecedor (email, tbl_fornecedores_id)
VALUES ('marques@fornecedora.com', 1);


INSERT INTO tbl_telefone_fornecedor (numero, tbl_fornecedores_id)
VALUES ('(11) 1234-5678', 1);


INSERT INTO tbl_endereco_fornecedor (cidade, logradouro, bairro, cep, pais, estado, tbl_fornecedores_id)
VALUES ('São Paulo', 'Rua A', 'Centro', '12345-678', 'Brasil', 'SP', 1);


INSERT INTO tbl_clientes (nome, data_cadastro, historico_compras, cpf)
VALUES ('Franciel', '2024-01-01', 'Nenhuma compra realizada', '12345678901');


INSERT INTO tbl_email_clientes (email, tbl_clientes_id)
VALUES ('Franciel@gmail.com', 1);


INSERT INTO tbl_telefone_clientes (numero, tbl_clientes_id)
VALUES ('(11) 8765-4321', 1);


INSERT INTO tbl_endereco_clientes (logradouro, cidade, estado, pais, bairro, cep, tbl_clientes_id)
VALUES ('Rua B', 'Rio de Janeiro', 'RJ', 'Brasil', 'Centro', '98765-432', 1);


INSERT INTO tbl_colaboradores (nome, salario, departamento, data_contratacao, cargo, numero_registro)
VALUES ('Osvaldo', 2500.00, 'Vendas', '2023-01-15', 'Vendedor', 1001);


INSERT INTO tbl_produtos (nome, valor_compra, valor_venda, data_validade, codigo_de_barras, descricao, preco, qntd_estoque, categoria, tbl_fornecedores_id)
VALUES ('Arroz', 10.00, 15.00, '2024-12-31', '123456789012', 'Não perecível', 15.00, 100, 'Alimento', 1);


INSERT INTO tbl_estoque (data_entrada, qntd_disponivel, data_saida, localizacao_deposito, tbl_produtos_id, tbl_fornecedores_id)
VALUES ('2024-01-01', 50, NULL, 'Depósito Leste', 1, 1);


INSERT INTO tbl_pedidos (status_pedido, valor_total, data_pedido, data_entrega, numero_pedido, tbl_clientes_id, tbl_colaboradores_id)
VALUES ('pendente', 150.00, '2024-01-15', '2024-01-20', 12345, 1, 1);


INSERT INTO tbl_vendas (status_vendas, data_hora, valor_total, tbl_colaboradores_id)
VALUES ('confirmada', '2024-01-15 14:30:00', 150.00, 1);


INSERT INTO tbl_itens_vendas (preco_unitario, subtotal, quantidade, tbl_pedidos_id, tbl_vendas_id)
VALUES (15.00, 45.00, 3, 1, 1);


INSERT INTO tbl_pagamentos (status_pagamentos, valor_pago, metodo_pagamento, data_pagamento, tbl_vendas_id)
VALUES ('pago', 150.00, 'cartao_credito', '2024-01-15 15:00:00', 1);


INSERT INTO tbl_devolucoes (motivo_devolucao, qntd_devolvida, status_devolucao, valor_estornado, data_devolucao, tbl_vendas_id, tbl_colaboradores_id)
VALUES ('Produto com defeito', 1, 'aprovada', 15.00, '2024-01-20', 1, 1);

```



## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
---
