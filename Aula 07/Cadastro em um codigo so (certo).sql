-- Criação do banco de dados e tabelas
CREATE DATABASE dados_cadastrais;

USE dados_cadastrais;

CREATE TABLE Pessoa (
    cliente_id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    nacionalidade VARCHAR(255) NOT NULL,
    sexo ENUM('M','F','O') NOT NULL,
    estado_civil ENUM('solteiro','casado','divorciado','viuvo','separado'),
    rg VARCHAR(20) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (cliente_id),
    UNIQUE KEY (rg),
    UNIQUE KEY (cpf)
);

CREATE TABLE Cadastro (
    cadastro_id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    matricula VARCHAR(20) NOT NULL,
    data_admissao DATE NOT NULL,
    data_demissao DATE NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (cadastro_id),
    FOREIGN KEY (cliente_id) REFERENCES Pessoa(cliente_id),
    UNIQUE KEY (matricula)
);

CREATE TABLE Endereco (
    endereco_id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero INT,
    complemento VARCHAR(100),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(9) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (endereco_id),
    FOREIGN KEY (cliente_id) REFERENCES Pessoa(cliente_id)
);

CREATE TABLE Cargo (
    cargo_id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (cargo_id),
    FOREIGN KEY (cliente_id) REFERENCES Pessoa(cliente_id)
);

CREATE TABLE Lotacao (
    lotacao_id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (lotacao_id),
    FOREIGN KEY (cliente_id) REFERENCES Pessoa(cliente_id)
);

CREATE TABLE Dependente (
    cliente_id INT NOT NULL,
    titular_id INT NOT NULL,
    parentesco ENUM('filho','conjuge','outros') NOT NULL,
    dependente_fiscal BOOLEAN NOT NULL DEFAULT FALSE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (cliente_id),
    FOREIGN KEY (cliente_id) REFERENCES Pessoa(cliente_id),
    FOREIGN KEY (titular_id) REFERENCES Pessoa(cliente_id)
);

-- Inserção de dados de exemplo
INSERT INTO Pessoa (nome, sobrenome, data_nascimento, nacionalidade, sexo, estado_civil, rg, cpf) VALUES
  ('João','Silva','1980-05-15','Brasileira','M', 'casado','MG1234567','123.456.789-00'),
  ('Maria','Oliveira','1985-09-30','Brasileira','F','solteiro','SP7654321','987.654.321-00'),
  ('Pedro','Souza','1975-12-10','Brasileira','M','divorciado','RJ1122334','111.222.333-44'),
  ('Ana','Silva','2010-03-20','Brasileira','F',NULL,'MG9988776','222.333.444-55'),
  ('Lucas','Silva','2012-07-08','Brasileira','M',NULL,'MG5544332','333.444.555-66');

INSERT INTO Cadastro (cliente_id, matricula, data_admissao) VALUES
  (1,'MATR-001','2005-01-10'),
  (2,'MATR-002','2010-05-22'),
  (3,'MATR-003','2000-09-15');

INSERT INTO Endereco (cliente_id, rua, numero, complemento, bairro, cidade, estado, cep) VALUES
  (1,'Av. Paulista', 1234, 'Apto 101', 'Bela Vista','São Paulo','SP','01310-100'),
  (2,'Rua das Flores',567, NULL,'Centro','Campinas','SP','13010-200'),
  (3,'Av. Brasil',890, NULL,'Centro','Rio de Janeiro','RJ','20010-000');

INSERT INTO Cargo (cliente_id, cargo, data_inicio, data_fim) VALUES
  (1, 'Analista','2005-01-10', '2010-12-31'),
  (1, 'Coordenador','2011-01-01', '2018-06-30'),
  (1, 'Gerente','2018-07-01', NULL),
  (2, 'Assistente','2010-05-22', '2015-08-15'),
  (2, 'Supervisor','2015-08-16', NULL),
  (3, 'Estagiário','2000-09-15', '2002-12-31');

INSERT INTO Lotacao (cliente_id, departamento, data_inicio, data_fim) VALUES
  (1, 'Financeiro','2005-01-10','2008-03-31'),
  (1, 'RH','2008-04-01','2014-02-28'),
  (1, 'Tecnologia','2014-03-01',NULL),
  (2, 'Logística','2010-05-22','2012-11-30'),
  (2, 'Operações','2012-12-01',NULL),
  (3, 'Marketing','2000-09-15','2003-06-30');

INSERT INTO Dependente (cliente_id, titular_id, parentesco, dependente_fiscal) VALUES
  (4, 1, 'filho', TRUE),
  (5, 1, 'filho', TRUE);

-- Criação de Views
CREATE VIEW vw_funcionarios_ativos AS
SELECT 
    p.cliente_id,
    CONCAT(p.nome, ' ', p.sobrenome) AS nome_completo,
    p.cpf,
    c.matricula,
    c.data_admissao,
    TIMESTAMPDIFF(YEAR, c.data_admissao, CURDATE()) AS tempo_empresa,
    co.cargo AS cargo_atual,
    l.departamento AS departamento_atual
FROM Pessoa p
JOIN Cadastro c ON p.cliente_id = c.cliente_id AND c.data_demissao IS NULL
LEFT JOIN Cargo co ON p.cliente_id = co.cliente_id AND co.data_fim IS NULL
LEFT JOIN Lotacao l ON p.cliente_id = l.cliente_id AND l.data_fim IS NULL;

CREATE VIEW vw_historico_profissional AS
SELECT 
    p.cliente_id,
    CONCAT(p.nome, ' ', p.sobrenome) AS funcionario,
    c.matricula,
    co.cargo,
    co.data_inicio AS inicio_cargo,
    co.data_fim AS fim_cargo,
    l.departamento,
    l.data_inicio AS inicio_lotacao,
    l.data_fim AS fim_lotacao,
    DATEDIFF(IFNULL(co.data_fim, CURDATE()), co.data_inicio) AS dias_no_cargo
FROM Pessoa p
JOIN Cadastro c ON p.cliente_id = c.cliente_id
LEFT JOIN Cargo co ON p.cliente_id = co.cliente_id
LEFT JOIN Lotacao l ON p.cliente_id = l.cliente_id
    AND (
        (co.data_inicio BETWEEN l.data_inicio AND IFNULL(l.data_fim, '9999-12-31'))
        OR
        (IFNULL(co.data_fim, '9999-12-31') BETWEEN l.data_inicio AND IFNULL(l.data_fim, '9999-12-31'))
    )
ORDER BY p.cliente_id, co.data_inicio;

-- Consultas de análise
-- 1. Lista completa de pessoas com informações básicas
SELECT 
    p.cliente_id,
    CONCAT(p.nome, ' ', p.sobrenome) AS nome_completo,
    p.data_nascimento,
    TIMESTAMPDIFF(YEAR, p.data_nascimento, CURDATE()) AS idade,
    p.sexo,
    p.estado_civil,
    p.cpf,
    CASE WHEN d.cliente_id IS NOT NULL THEN 'Dependente' ELSE 'Titular' END AS tipo
FROM Pessoa p
LEFT JOIN Dependente d ON p.cliente_id = d.cliente_id
ORDER BY p.nome, p.sobrenome;

-- 2. Relatório de funcionários ativos com seus cargos e departamentos
SELECT 
    v.nome_completo,
    v.cargo_atual,
    v.departamento_atual,
    v.tempo_empresa AS anos_na_empresa,
    e.rua,
    e.numero,
    e.complemento,
    e.bairro,
    e.cidade,
    e.estado,
    e.cep
FROM vw_funcionarios_ativos v
JOIN Endereco e ON v.cliente_id = e.cliente_id;

-- 3. Análise de dependentes por funcionário
SELECT 
    t.cliente_id AS id_titular,
    CONCAT(t.nome, ' ', t.sobrenome) AS titular,
    d.cliente_id AS id_dependente,
    CONCAT(d.nome, ' ', d.sobrenome) AS dependente,
    TIMESTAMPDIFF(YEAR, d.data_nascimento, CURDATE()) AS idade_dependente,
    dep.parentesco,
    dep.dependente_fiscal
FROM Pessoa t
JOIN Dependente dep ON t.cliente_id = dep.titular_id
JOIN Pessoa d ON dep.cliente_id = d.cliente_id
ORDER BY t.cliente_id, d.data_nascimento;

-- 4. Histórico de promoções (mudanças de cargo)
SELECT 
    p.cliente_id,
    CONCAT(p.nome, ' ', p.sobrenome) AS funcionario,
    c.cargo,
    c.data_inicio,
    c.data_fim,
    DATEDIFF(IFNULL(c.data_fim, CURDATE()), c.data_inicio) AS dias_no_cargo,
    ROUND(DATEDIFF(IFNULL(c.data_fim, CURDATE()), c.data_inicio)/365, 1) AS anos_no_cargo,
    l.departamento
FROM Pessoa p
JOIN Cargo c ON p.cliente_id = c.cliente_id
JOIN Lotacao l ON p.cliente_id = l.cliente_id
    AND c.data_inicio BETWEEN l.data_inicio AND IFNULL(l.data_fim, '9999-12-31')
ORDER BY p.cliente_id, c.data_inicio;

-- 5. Aniversariantes do mês atual
SELECT 
    cliente_id,
    CONCAT(nome, ' ', sobrenome) AS nome_completo,
    data_nascimento,
    TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade,
    DAY(data_nascimento) AS dia_aniversario,
    IFNULL(departamento_atual, 'Não é funcionário') AS departamento
FROM vw_funcionarios_ativos
WHERE MONTH(data_nascimento) = MONTH(CURDATE())
ORDER BY dia_aniversario;

-- 6. Funcionários elegíveis para promoção (5+ anos no mesmo cargo)
SELECT 
    p.cliente_id,
    CONCAT(p.nome, ' ', p.sobrenome) AS funcionario,
    c.cargo AS cargo_atual,
    ROUND(DATEDIFF(CURDATE(), c.data_inicio)/365, 1) AS anos_no_cargo,
    l.departamento
FROM Pessoa p
JOIN Cargo c ON p.cliente_id = c.cliente_id AND c.data_fim IS NULL
JOIN Lotacao l ON p.cliente_id = l.cliente_id AND l.data_fim IS NULL
WHERE DATEDIFF(CURDATE(), c.data_inicio)/365 >= 5
ORDER BY anos_no_cargo DESC;

-- 7. Movimentação entre departamentos
SELECT 
    l1.cliente_id,
    CONCAT(p.nome, ' ', p.sobrenome) AS funcionario,
    l1.departamento AS depto_anterior,
    l2.departamento AS depto_atual,
    l1.data_fim AS data_transferencia,
    DATEDIFF(l2.data_inicio, l1.data_inicio) AS dias_no_depto_anterior
FROM Lotacao l1
JOIN Lotacao l2 ON l1.cliente_id = l2.cliente_id AND l2.data_inicio = (
    SELECT MIN(data_inicio) 
    FROM Lotacao 
    WHERE cliente_id = l1.cliente_id AND data_inicio > l1.data_inicio
)
JOIN Pessoa p ON l1.cliente_id = p.cliente_id
WHERE l1.data_fim IS NOT NULL
ORDER BY l1.data_fim DESC;

-- 8. Relatório de turnover (admissões e demissões por ano)
SELECT 
    YEAR(data_admissao) AS ano,
    COUNT(*) AS admitidos,
    SUM(CASE WHEN data_demissao IS NOT NULL THEN 1 ELSE 0 END) AS demitidos,
    ROUND(SUM(CASE WHEN data_demissao IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_turnover
FROM Cadastro
GROUP BY YEAR(data_admissao)
ORDER BY ano;