create database sistema_fac;

use sistema_fac;

CREATE TABLE tbl_alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(15) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    ra VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE tbl_professores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(15) UNIQUE NOT NULL,
    data_contratacao DATE NOT NULL,
    status_professor ENUM('ativo', 'afastado', 'desligado') NOT NULL,
    disciplinas_principais VARCHAR(100) NOT NULL
);

CREATE TABLE tbl_cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(250) NOT NULL,
    duracao TINYINT NOT NULL,
    nivel_curso ENUM('graduação', 'pós-graduação', 'técnico') NOT NULL,
    modalidade ENUM('presencial', 'ead', 'hibrido') NOT NULL,
    valor_mensalidade DECIMAL(10,2) NOT NULL,
    descricao TEXT
);

CREATE TABLE tbl_endereco_aluno (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cep VARCHAR(15) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    pais VARCHAR(45) NOT NULL,
    logradouro VARCHAR(150) NOT NULL,
    numero VARCHAR(15) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    tbl_alunos_id INT NOT NULL,
    CONSTRAINT fk_endereco_aluno FOREIGN KEY (tbl_alunos_id) REFERENCES tbl_alunos(id) ON DELETE CASCADE
);

CREATE TABLE tbl_email_aluno (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    tbl_alunos_id INT NOT NULL,
    CONSTRAINT fk_email_aluno FOREIGN KEY (tbl_alunos_id) REFERENCES tbl_alunos(id) ON DELETE CASCADE
);

CREATE TABLE tbl_telefone_aluno (
    id INT PRIMARY KEY AUTO_INCREMENT,
    telefone VARCHAR(15) NOT NULL,
    tbl_alunos_id INT NOT NULL,
    CONSTRAINT fk_telefone_aluno FOREIGN KEY (tbl_alunos_id) REFERENCES tbl_alunos(id) ON DELETE CASCADE
);

CREATE TABLE tbl_email_professores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    tbl_professores_id INT NOT NULL,
    CONSTRAINT fk_email_professores FOREIGN KEY (tbl_professores_id) REFERENCES tbl_professores(id) ON DELETE CASCADE
);

CREATE TABLE tbl_telefone_professores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    telefone VARCHAR(15) NOT NULL,
    tbl_professores_id INT NOT NULL,
    CONSTRAINT fk_telefone_professores FOREIGN KEY (tbl_professores_id) REFERENCES tbl_professores(id) ON DELETE CASCADE
);

CREATE TABLE tbl_turmas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    periodo ENUM('manhã', 'tarde', 'noite') NOT NULL,
    capacidade_maxima TINYINT NOT NULL,
    sala VARCHAR(50) NOT NULL,
    qtd_atual_alunos TINYINT DEFAULT 0,
    tbl_cursos_id INT NOT NULL,
    CONSTRAINT fk_turmas_cursos FOREIGN KEY (tbl_cursos_id) REFERENCES tbl_cursos(id) ON DELETE CASCADE
);

CREATE TABLE tbl_materia (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_materia VARCHAR(150) NOT NULL,
    carga_horaria SMALLINT NOT NULL,
    descricao TEXT,
    periodo_recomendado TINYINT NOT NULL
);

CREATE TABLE tbl_turmas_materia (
    tbl_turmas_id INT NOT NULL,
    tbl_materia_id INT NOT NULL,
    ano_semestre VARCHAR(6) NOT NULL,
    horario_aulas VARCHAR(20) NOT NULL,
    tbl_professores_id INT NOT NULL,
    PRIMARY KEY (tbl_turmas_id, tbl_materia_id),
    CONSTRAINT fk_turmas_turmas_materia FOREIGN KEY (tbl_turmas_id) REFERENCES tbl_turmas(id) ON DELETE CASCADE,
    CONSTRAINT fk_materias_turmas_materia FOREIGN KEY (tbl_materia_id) REFERENCES tbl_materia(id) ON DELETE CASCADE,
    CONSTRAINT fk_turmas_materia_professores FOREIGN KEY (tbl_professores_id) REFERENCES tbl_professores(id) ON DELETE CASCADE
);

CREATE TABLE tbl_matriculas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    observacoes TEXT,
    data_matricula DATE NOT NULL,
    status_matricula ENUM('ativa', 'cancelada') NOT NULL,
    metodo_pagamento ENUM('cartão crédito', 'cartão débito', 'pix', 'boleto', 'dinheiro') NOT NULL,
    tbl_turmas_id INT NOT NULL,
    tbl_alunos_id INT NOT NULL,
    CONSTRAINT fk_matriculas_turmas FOREIGN KEY (tbl_turmas_id) REFERENCES tbl_turmas(id) ON DELETE CASCADE,
    CONSTRAINT fk_matriculas_alunos FOREIGN KEY (tbl_alunos_id) REFERENCES tbl_alunos(id) ON DELETE CASCADE
);

CREATE TABLE tbl_avaliacoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_avaliacao ENUM('prova', 'trabalho', 'atividade') NOT NULL,
    peso DECIMAL(3,2) NOT NULL,
    pontuacao_maxima TINYINT NOT NULL,
    descricao TEXT,
    data_avaliacao DATE NOT NULL,
    duracao TINYINT NOT NULL,
    tbl_materia_id INT NOT NULL,
    CONSTRAINT fk_avaliacoes_materias FOREIGN KEY (tbl_materia_id) REFERENCES tbl_materia(id) ON DELETE CASCADE
);

CREATE TABLE tbl_nota (
    id INT PRIMARY KEY AUTO_INCREMENT,
    valor_nota DECIMAL(5,2) NOT NULL,
    data_lancamento DATE NOT NULL,
    status ENUM('parcial', 'final','revisada') NOT NULL,
    observacoes TEXT,
    tbl_avaliacoes_id INT NOT NULL,
    tbl_alunos_id INT NOT NULL,
    CONSTRAINT fk_nota_avaliacoes FOREIGN KEY (tbl_avaliacoes_id) REFERENCES tbl_avaliacoes(id) ON DELETE CASCADE,
    CONSTRAINT fk_nota_alunos FOREIGN KEY (tbl_alunos_id) REFERENCES tbl_alunos(id) ON DELETE CASCADE
);