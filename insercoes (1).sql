use sistema_fac;


INSERT INTO tbl_alunos (nome, cpf, data_nascimento, ra) VALUES
('João Silva', '123.456.789-10', '2001-05-20', 'RA12345'),
('Maria Oliveira', '987.654.321-00', '2000-10-15', 'RA54321');


INSERT INTO tbl_professores (nome, cpf, data_contratacao, status_professor, disciplinas_principais) VALUES
('Carlos Almeida', '111.222.333-44', '2018-03-01', 'ativo', 'Matemática'),
('Ana Paula', '555.666.777-88', '2020-01-15', 'afastado', 'Física');


INSERT INTO tbl_cursos (nome_curso, duracao, nivel_curso, modalidade, valor_mensalidade, descricao) VALUES
('Engenharia da Computação', 10, 'graduação', 'presencial', 1500.00, 'Curso de alta demanda no mercado de trabalho'),
('Ciência de Dados', 6, 'pós-graduação', 'ead', 800.00, 'Curso focado em análise de dados e inteligência artificial');


INSERT INTO tbl_endereco_aluno (cep, estado, pais, logradouro, numero, cidade, tbl_alunos_id) VALUES
('12345-678', 'SP', 'Brasil', 'Rua das Flores', '100', 'São Paulo', 1),
('98765-432', 'RJ', 'Brasil', 'Avenida Atlântica', '200', 'Rio de Janeiro', 2);


INSERT INTO tbl_email_aluno (email, tbl_alunos_id) VALUES
('joao.silva@gmail.com', 1),
('maria.oliveira@hotmail.com', 2);


INSERT INTO tbl_telefone_aluno (telefone, tbl_alunos_id) VALUES
('11999999999', 1),
('21988888888', 2);


INSERT INTO tbl_email_professores (email, tbl_professores_id) VALUES
('carlos.almeida@escola.com', 1),
('ana.paula@escola.com', 2);


INSERT INTO tbl_telefone_professores (telefone, tbl_professores_id) VALUES
('31977777777', 1),
('21966666666', 2);


INSERT INTO tbl_turmas (periodo, capacidade_maxima, sala, qtd_atual_alunos, tbl_cursos_id) VALUES
('manhã', 30, '101', 25, 1),
('noite', 40, '202', 35, 2);


INSERT INTO tbl_materia (nome_materia, carga_horaria, descricao, periodo_recomendado) VALUES
('Matemática Básica', 60, 'Introdução à Matemática para iniciantes', 1),
('Programação Avançada', 80, 'Curso avançado de desenvolvimento de software', 2);


INSERT INTO tbl_turmas_materia (tbl_turmas_id, tbl_materia_id, ano_semestre, horario_aulas, tbl_professores_id) VALUES
(1, 1, '2024-1', '08:00 - 10:00', 1),
(2, 2, '2024-1', '19:00 - 21:00', 2);


INSERT INTO tbl_matriculas (observacoes, data_matricula, status_matricula, metodo_pagamento, tbl_turmas_id, tbl_alunos_id) VALUES
('Aluno com bolsa parcial', '2024-01-10', 'ativa', 'cartão crédito', 1, 1),
('Aluno transferido de outra instituição', '2024-01-15', 'ativa', 'pix', 2, 2);


INSERT INTO tbl_avaliacoes (tipo_avaliacao, peso, pontuacao_maxima, descricao, data_avaliacao, duracao, tbl_materia_id) VALUES
('prova', 2.0, 100, 'Prova final de Matemática Básica', '2024-06-20', 2, 1),
('trabalho', 3.0, 100, 'Projeto final de Programação Avançada', '2024-06-25', 4, 2);


INSERT INTO tbl_nota (valor_nota, data_lancamento, status, observacoes, tbl_avaliacoes_id, tbl_alunos_id) VALUES
(85.5, '2024-06-22', 'final', 'Desempenho excelente', 1, 1),
(78.0, '2024-06-27', 'parcial', 'Revisão solicitada pelo aluno', 2, 2);

select * from tbl_avaliacoes;
