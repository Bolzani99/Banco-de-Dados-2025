USE consultorio_medico;

-- Convênios
INSERT INTO Convenio (nome, registro_ans, telefone, email, site) VALUES
('Unimed', '123456', '0800-123456', 'contato@unimed.com.br', 'www.unimed.com.br'),
('Amil', '654321', '0800-654321', 'contato@amil.com.br', 'www.amil.com.br'),
('Bradesco Saúde', '987654', '0800-987654', 'contato@bradescosaude.com.br', 'www.bradescosaude.com.br'),
('SulAmérica', '456789', '0800-456789', 'contato@sulamerica.com.br', 'www.sulamerica.com.br'),
('Hapvida', '789123', '0800-789123', 'contato@hapvida.com.br', 'www.hapvida.com.br');

-- Médicos
INSERT INTO Medico (nome, crm, uf_crm, especialidade_principal, especialidades_secundarias, telefone, celular, email) VALUES
('Dr. Carlos Mendes', 'CRM/SP 123456', 'SP', 'Cardiologia', 'Ecocardiografia, Arritmias', '(11) 9999-1111', '(11) 98888-1111', 'carlos.mendes@clinica.com'),
('Dra. Juliana Almeida', 'CRM/SP 654321', 'SP', 'Clínica Geral', 'Geriatria, Medicina Preventiva', '(11) 9999-2222', '(11) 98888-2222', 'juliana.almeida@clinica.com'),
('Dr. Roberto Santos', 'CRM/SP 987654', 'SP', 'Gastroenterologia', 'Endoscopia, Hepatologia', '(11) 9999-3333', '(11) 98888-3333', 'roberto.santos@clinica.com'),
('Dra. Fernanda Lima', 'CRM/RJ 123456', 'RJ', 'Pediatria', 'Neonatologia, Alergia Infantil', '(21) 9999-4444', '(21) 98888-4444', 'fernanda.lima@clinica.com'),
('Dr. Marcelo Costa', 'CRM/MG 654321', 'MG', 'Ortopedia', 'Traumatologia, Medicina Esportiva', '(31) 9999-5555', '(31) 98888-5555', 'marcelo.costa@clinica.com');

-- Pacientes
INSERT INTO Paciente (nome, data_nascimento, sexo, estado_civil, cpf, rg, orgao_emissor, telefone, celular, email, endereco, bairro, cidade, uf, cep, nome_mae, nome_pai, profissao, alergias, medicamentos_uso_continuo) VALUES
('Maria Silva', '1985-05-15', 'F', 'Casado', '123.456.789-00', '123456789', 'SSP/SP', '(11) 9999-8888', '(11) 98888-8888', 'maria@email.com', 'Rua das Flores, 123', 'Centro', 'São Paulo', 'SP', '01000-000', 'Ana Maria Silva', 'José Silva', 'Professora', 'Penicilina, Dipirona', 'Losartana 50mg 1x/dia'),
('João Santos', '1990-08-22', 'M', 'Solteiro', '987.654.321-00', '987654321', 'SSP/SP', '(11) 7777-6666', '(11) 97777-6666', 'joao@email.com', 'Av. Paulista, 1000', 'Bela Vista', 'São Paulo', 'SP', '01310-000', 'Maria Santos', 'Antônio Santos', 'Engenheiro', NULL, NULL),
('Ana Oliveira', '1978-11-30', 'F', 'Divorciado', '456.789.123-00', '456789123', 'SSP/SP', '(11) 5555-4444', '(11) 95555-4444', 'ana@email.com', 'Rua XV de Novembro, 50', 'República', 'São Paulo', 'SP', '01000-001', 'Clara Oliveira', 'Pedro Oliveira', 'Advogada', 'Dipirona', 'Omeprazol 20mg 1x/dia'),
('Pedro Costa', '2000-03-10', 'M', 'Solteiro', '321.654.987-00', '321654987', 'SSP/RJ', '(21) 3333-2222', '(21) 93333-2222', 'pedro@email.com', 'Rua do Catete, 300', 'Catete', 'Rio de Janeiro', 'RJ', '22220-000', 'Lucia Costa', 'Carlos Costa', 'Estudante', 'Amoxicilina', NULL),
('Carla Mendes', '1995-07-20', 'F', 'União Estável', '654.321.987-00', '654321987', 'SSP/MG', '(31) 4444-3333', '(31) 94444-3333', 'carla@email.com', 'Av. Afonso Pena, 1000', 'Funcionários', 'Belo Horizonte', 'MG', '30130-000', 'Tereza Mendes', 'Roberto Mendes', 'Médica', 'Iodo', 'Levotiroxina 50mcg 1x/dia');

-- Relacionamento Paciente-Convênio
INSERT INTO Paciente_Convenio (id_paciente, id_convenio, numero_carteira, validade, titular, plano) VALUES
(1, 1, 'UNI123456', '2024-12-31', 'Maria Silva', 'Plano Ouro'),
(2, 2, 'AMIL654321', '2023-06-30', 'João Santos', 'Plano Prata'),
(3, 3, 'BRD987654', '2023-12-31', 'Ana Oliveira', 'Plano Diamante'),
(4, 4, 'SUL456789', '2023-09-30', 'Pedro Costa', 'Plano Universitário'),
(5, 5, 'HAP789123', '2024-06-30', 'Carla Mendes', 'Plano Executivo');

-- Tipos de Exames
INSERT INTO Tipo_Exame (nome, descricao, preparo, codigo_tuss, valor_referencia, tempo_entrega) VALUES
('Hemograma completo', 'Avaliação quantitativa e qualitativa dos elementos figurados do sangue', 'Jejum de 4 horas', '40301023', 50.00, '24 horas'),
('Eletrocardiograma', 'Registro gráfico da atividade elétrica do coração', 'Não fumar 2 horas antes do exame', '40301256', 120.00, '48 horas'),
('Endoscopia digestiva alta', 'Exame visual do esôfago, estômago e duodeno', 'Jejum de 8 horas', '40901010', 350.00, '7 dias'),
('Ultrassonografia abdominal total', 'Avaliação de órgãos abdominais por imagem', 'Jejum de 6 horas e evitar gases', '40901220', 280.00, '3 dias'),
('Glicemia em jejum', 'Dosagem de glicose no sangue', 'Jejum de 8 horas obrigatório', '40301159', 25.00, '24 horas');

-- Laboratórios
INSERT INTO Laboratorio (nome, telefone, email, endereco, responsavel, cnpj) VALUES
('Lab Exame', '(11) 2222-1111', 'contato@labexame.com.br', 'Rua dos Exames, 100 - São Paulo/SP', 'Dr. Exames Silva', '12.345.678/0001-11'),
('Cardio Lab', '(11) 3333-2222', 'contato@cardiolab.com.br', 'Av. Cardiologia, 200 - São Paulo/SP', 'Dra. Coração Forte', '23.456.789/0001-22'),
('Gastro Center', '(11) 4444-3333', 'contato@gastrocenter.com.br', 'Rua do Estômago, 300 - São Paulo/SP', 'Dr. Digestivo Legal', '34.567.890/0001-33'),
('Imagem Médica', '(11) 5555-4444', 'contato@imagemmedica.com.br', 'Av. das Imagens, 400 - São Paulo/SP', 'Dr. Ultrassom', '45.678.901/0001-44');

-- Medicamentos
INSERT INTO Medicamento (nome, principio_ativo, apresentacao, laboratorio, tarja) VALUES
('Losartana Potássica', 'Losartana', 'Comprimido 50mg 30un', 'EMS', 'Vermelha'),
('Omeprazol', 'Omeprazol', 'Cápsula 20mg 28un', 'Eurofarma', 'Vermelha'),
('Dipirona Sódica', 'Dipirona', 'Gotas 500mg/mL 10mL', 'Neo Química', 'Vermelha'),
('Amoxicilina', 'Amoxicilina', 'Cápsula 500mg 21un', 'Aché', 'Vermelha'),
('Levotiroxina Sódica', 'Levotiroxina', 'Comprimido 50mcg 30un', 'Sanofi', 'Preta');

-- Agendamentos
INSERT INTO Agendamento (id_paciente, id_medico, data_hora, duracao, motivo, status) VALUES
(1, 1, '2023-01-10 09:00:00', 30, 'Consulta de rotina', 'Realizado'),
(2, 2, '2023-02-15 14:30:00', 30, 'Febre e dor de garganta', 'Realizado'),
(1, 1, '2023-03-20 10:15:00', 30, 'Retorno hipertensão', 'Realizado'),
(3, 3, '2023-04-05 11:00:00', 40, 'Dor abdominal', 'Realizado'),
(4, 4, '2023-05-12 08:30:00', 30, 'Consulta pediátrica', 'Agendado'),
(5, 5, '2023-06-18 15:00:00', 40, 'Dor no joelho', 'Agendado');

-- Consultas
INSERT INTO Consulta (id_paciente, id_medico, id_paciente_convenio, data_hora, data_hora_fim, duracao, tipo, diagnostico, cid, prescricao, observacoes, status, valor, valor_desconto, forma_pagamento) VALUES
(1, 1, 1, '2023-01-10 09:00:00', '2023-01-10 09:30:00', 30, 'Consulta', 'Hipertensão arterial estágio 1', 'I10', 'Losartana 50mg 1x/dia', 'Paciente orientada sobre dieta hipossódica', 'Realizada', 300.00, 0.00, 'Convênio'),
(2, 2, 2, '2023-02-15 14:30:00', '2023-02-15 15:00:00', 30, 'Consulta', 'Resfriado comum', 'J00', 'Repouso e hidratação', 'Paciente com sintomas leves, sem necessidade de medicação específica', 'Realizada', 250.00, 0.00, 'Convênio'),
(1, 1, 1, '2023-03-20 10:15:00', '2023-03-20 10:45:00', 30, 'Retorno', 'Acompanhamento hipertensão', 'I10', 'Manter medicação', 'PA controlada com medicação atual', 'Realizada', 200.00, 0.00, 'Convênio'),
(3, 3, 3, '2023-04-05 11:00:00', '2023-04-05 11:40:00', 40, 'Consulta', 'Gastrite aguda', 'K29.7', 'Omeprazol 20mg 1x/dia por 30 dias', 'Solicitada endoscopia para confirmação diagnóstica', 'Realizada', 350.00, 0.00, 'Convênio');

-- Exames
INSERT INTO Exame (id_consulta, id_tipo_exame, id_laboratorio, data_solicitacao, data_realizacao, data_entrega, resultado, observacoes, status, valor) VALUES
(1, 1, 1, '2023-01-10 09:30:00', '2023-01-11', '2023-01-12', 'Hemograma dentro dos parâmetros normais', NULL, 'Entregue', 50.00),
(1, 2, 2, '2023-01-10 09:30:00', '2023-01-12', '2023-01-14', 'ECG com ritmo sinusal, sem alterações', NULL, 'Entregue', 120.00),
(3, 1, 1, '2023-03-20 10:45:00', '2023-03-21', '2023-03-22', 'Hemograma normal', NULL, 'Entregue', 50.00),
(4, 3, 3, '2023-04-05 11:40:00', '2023-04-10', '2023-04-17', 'Endoscopia com sinais de gastrite moderada', 'Biópsia realizada para H. pylori', 'Entregue', 350.00),
(4, 4, 4, '2023-04-05 11:40:00', '2023-04-10', '2023-04-13', 'USG abdominal sem alterações significativas', NULL, 'Entregue', 280.00);

-- Prescrições
INSERT INTO Prescricao (id_consulta, id_medicamento, posologia, quantidade, duracao, observacoes) VALUES
(1, 1, '1 comprimido ao dia pela manhã', 30, '30 dias', 'Controlar pressão arterial semanalmente'),
(4, 2, '1 cápsula ao dia em jejum', 28, '30 dias', 'Evitar álcool e alimentos irritantes');