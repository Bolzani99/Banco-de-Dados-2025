USE dados_cadastrais;

-- 1) Titulares e dependentes
INSERT INTO Pessoa (nome, sobrenome, data_nascimento, nacionalidade, sexo, estado_civil, rg, cpf)
VALUES
  ('João','Silva','1980-05-15','Brasileira','M', 'casado','MG1234567','123.456.789-00'),
  ('Maria','Oliveira','1985-09-30','Brasileira','F','solteiro','SP7654321','987.654.321-00'),
  ('Pedro','Souza','1975-12-10','Brasileira','M','divorciado','RJ1122334','111.222.333-44'),
  
  -- dependentes de João (cliente_id = 1)
  ('Ana','Silva','2010-03-20','Brasileira','F',NULL,'MG9988776','222.333.444-55'),
  ('Lucas','Silva','2012-07-08','Brasileira','M',NULL,'MG5544332','333.444.555-66');

-- 2) Cadastro
INSERT INTO Cadastro (cliente_id, matricula, data_admissao)
VALUES
  (1,'MATR-001','2005-01-10'),
  (2,'MATR-002','2010-05-22'),
  (3,'MATR-003','2000-09-15');
  -- dependentes não têm cadastro de emprego

-- 3) Enderecos
INSERT INTO Endereco (cliente_id, rua, numero, complemento, bairro, cidade, estado, cep)
VALUES
  (1,'Av. Paulista', 1234, 'Apto 101', 'Bela Vista','São Paulo','SP','01310-100'),
  (2,'Rua das Flores',567, NULL,'Centro','Campinas','SP','13010-200'),
  (3,'Av. Brasil',890, NULL,'Centro','Rio de Janeiro','RJ','20010-000');

-- 4) Cargos Ocupados
INSERT INTO Cargos_Ocupados (cliente_id, cargo, data_inicio, data_fim)
VALUES
  (1, 'Analista','2005-01-10', '2010-12-31'),
  (1, 'Coordenador','2011-01-01', '2018-06-30'),
  (1, 'Gerente','2018-07-01', NULL),
  (2, 'Assistente','2010-05-22', '2015-08-15'),
  (2, 'Supervisor','2015-08-16', NULL),
  (3, 'Estagiário','2000-09-15', '2002-12-31');

-- 5) Departamento de Lotação
INSERT INTO Departamento_Lotacao (cliente_id, departamento, data_inicio, data_fim)
VALUES
  (1, 'Financeiro','2005-01-10','2008-03-31'),
  (1, 'RH','2008-04-01','2014-02-28'),
  (1, 'Tecnologia','2014-03-01',NULL),
  (2, 'Logística','2010-05-22','2012-11-30'),
  (2, 'Operações','2012-12-01',NULL),
  (3, 'Marketing','2000-09-15','2003-06-30');

-- 6) Dependentes (herdam de Pessoa)
-- supondo IDs: Ana (4) e Lucas (5) são dependentes de João (1)
INSERT INTO Dependente (cliente_id, titular_id)
VALUES
  (4, 1),
  (5, 1);