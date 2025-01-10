use supermercado;

-- 1. Tabela de Fornecedores
INSERT INTO tbl_fornecedores (nome_fornecedor, cnpj, produtos_fornecidos, valor_frete)
VALUES ('Marques Fornecedora', '12345678901234', 'Palete de arroz, Palete de feijão', 100.00);

-- 2. Tabela de E-mail dos Fornecedores
INSERT INTO tbl_email_fornecedor (email, tbl_fornecedores_id)
VALUES ('marques@fornecedora.com', 1);

-- 3. Tabela de Telefone dos Fornecedores
INSERT INTO tbl_telefone_fornecedor (numero, tbl_fornecedores_id)
VALUES ('(11) 1234-5678', 1);

-- 4. Tabela de Endereço dos Fornecedores
INSERT INTO tbl_endereco_fornecedor (cidade, logradouro, bairro, cep, pais, estado, tbl_fornecedores_id)
VALUES ('São Paulo', 'Rua A', 'Centro', '12345-678', 'Brasil', 'SP', 1);

-- 5. Tabela de Clientes
INSERT INTO tbl_clientes (nome, data_cadastro, historico_compras, cpf)
VALUES ('Franciel', '2024-01-01', 'Nenhuma compra realizada', '12345678901');

-- 6. Tabela de E-mail dos Clientes
INSERT INTO tbl_email_clientes (email, tbl_clientes_id)
VALUES ('Franciel@gmail.com', 1);

-- 7. Tabela de Telefone dos Clientes
INSERT INTO tbl_telefone_clientes (numero, tbl_clientes_id)
VALUES ('(11) 8765-4321', 1);

-- 8. Tabela de Endereço dos Clientes
INSERT INTO tbl_endereco_clientes (logradouro, cidade, estado, pais, bairro, cep, tbl_clientes_id)
VALUES ('Rua B', 'Rio de Janeiro', 'RJ', 'Brasil', 'Centro', '98765-432', 1);

-- 9. Tabela de Colaboradores
INSERT INTO tbl_colaboradores (nome, salario, departamento, data_contratacao, cargo, numero_registro)
VALUES ('Osvaldo', 2500.00, 'Vendas', '2023-01-15', 'Vendedor', 1001);

-- 10. Tabela de Produtos
INSERT INTO tbl_produtos (nome, valor_compra, valor_venda, data_validade, codigo_de_barras, descricao, preco, qntd_estoque, categoria, tbl_fornecedores_id)
VALUES ('Arroz', 10.00, 15.00, '2024-12-31', '123456789012', 'Não perecível', 15.00, 100, 'Alimento', 1);

-- 11. Tabela de Estoque
INSERT INTO tbl_estoque (data_entrada, qntd_disponivel, data_saida, localizacao_deposito, tbl_produtos_id, tbl_fornecedores_id)
VALUES ('2024-01-01', 50, NULL, 'Depósito Leste', 1, 1);

-- 12. Tabela de Pedidos
INSERT INTO tbl_pedidos (status_pedido, valor_total, data_pedido, data_entrega, numero_pedido, tbl_clientes_id, tbl_colaboradores_id)
VALUES ('pendente', 150.00, '2024-01-15', '2024-01-20', 12345, 1, 1);

-- 13. Tabela de Vendas
INSERT INTO tbl_vendas (status_vendas, data_hora, valor_total, tbl_colaboradores_id)
VALUES ('confirmada', '2024-01-15 14:30:00', 150.00, 1);

-- 14. Tabela de Itens Vendidos
INSERT INTO tbl_itens_vendas (preco_unitario, subtotal, quantidade, tbl_pedidos_id, tbl_vendas_id)
VALUES (15.00, 45.00, 3, 1, 1);

-- 15. Tabela de Pagamentos
INSERT INTO tbl_pagamentos (status_pagamentos, valor_pago, metodo_pagamento, data_pagamento, tbl_vendas_id)
VALUES ('pago', 150.00, 'cartao_credito', '2024-01-15 15:00:00', 1);

-- 16. Tabela de Devoluções
INSERT INTO tbl_devolucoes (motivo_devolucao, qntd_devolvida, status_devolucao, valor_estornado, data_devolucao, tbl_vendas_id, tbl_colaboradores_id)
VALUES ('Produto com defeito', 1, 'aprovada', 15.00, '2024-01-20', 1, 1);
