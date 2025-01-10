# Análise de Requisitos

**Evidenciando as necessidades dos Stakeholders.**

**Aluno**: Franciel Marques Fagundes  
**Disciplina**: Database Modeling & SQL

---

## 1° - Quais as principais necessidades dos clientes?

**•** Gerenciar informações detalhadas sobre alunos, professores, cursos, matérias, turmas, matrículas, avaliações e nota.

 **•** Controlar o status de alunos, professores e matrículas para fins administrativos.

 **•** Registrar dados de matrículas e rastrear histórico acadêmico dos alunos.

 **•** Realizar o planejamento e gerenciamento de turmas e alocação de matérias.

 **•** Registrar avaliações e notas para acompanhamento do desempenho dos alunos.

 **•** Permitir consultar e emissão de relatórios detalhados sobre o desempenho acadêmico e administrativo.

 ---

 ## 2° - Quais informações precisam ser armazenadas?

### Alunos:

• Dados pessoais: Nome, CPF, data de nascimento, endereço completo, telefone e e-mail.

• Informações acadêmicas: Data de ingresso, status da matrícula (ativa, trancada, concluída).

• Outros dados: Registro acadêmico (RA)

### Professores:

• Dados pessoais: Nome, CPF, e-mail e telefone.

• Informações administrativas: Data de contratação, status do professor (ativo, afastado, desligado).

• Dados acadêmicos: Disciplinas principais.

### Cursos:

• Dados básicos: Nome do curso, nível (ex.: graduação, pós-graduação, técnico), duração, descrição.

• Informações adicionais: Modalidade (presencial, EAD, híbrido), valor mensalidade. 

• Coordenação: Nome ou referência ao professor coordenador do curso.

### Matérias:

• Dados básicos: Nome, carga horária, período recomendado, descrição. 

### Turmas:

• Dados básicos: Período (manhã, tarde, noite), ano e semestre de criação.

• Informações adicionais: Capacidade máxima, sala, horário, professor tutor, número atual de alunos 
matriculados. 

### Matrículas:

• Dados básicos: Identificador único da matricula, aluno associado, turma associada, data da matrícula, status 
da matrícula (ativa, cancelada).

• Informações adicionais: Forma de pagamento, e observações.

### Avaliações:

• Dados básicos: Identificador único, tipo (.: prova, trabalho, atividade), peso, data de avaliação.

• Informações adicionais: Duração, pontuação máxima, e descrição da avaliação.

### Notas:

• Dados básicos: Valor da nota, aluno associado, avaliação associada.

• Informações adicionais: Data de lançamento, professor responsável, status da nota (parcial, final, revisada), 
observações.

---

## 3° - O que será feito com os dados posteriormente?

**• Consultas e relatórios detalhados:**

• Histórico acadêmico dos alunos. 

• Relatório de desempenho por matéria, turma ou professor. 

• Controle administrativo de status e dados financeiros de matrículas.

• Planejamento de turmas, alocação de professores e organização de cronogramas.

• Rastreamento das alterações feitas em notas e matrículas.

---
# **Modelo Conceitual.**
![Conceitual](modelo_conceitual.jpg)

---
# **Modelo Lógico.**
![Lógico](modelo_logico.png)

---
# **Código SQL - Tabelas.**

```sql
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

```
---

# **Código SQL - Inserções.**

```sql
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

```
