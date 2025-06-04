-- Inserindo Especialidades
INSERT INTO Especialidade (nome, descricao) VALUES
('Cardiologia', 'Especialidade médica que trata do coração e sistema cardiovascular'),
('Dermatologia', 'Especialidade médica que trata da pele e seus anexos'),
('Pediatria', 'Especialidade médica dedicada à saúde infantil'),
('Ortopedia', 'Especialidade médica que trata do sistema musculoesquelético'),
('Ginecologia', 'Especialidade médica que trata da saúde da mulher');

-- Inserindo Médicos
INSERT INTO Medico (nome, crm, uf_crm, telefone, email) VALUES
('Dr. Carlos Silva', '12345-SP', 'SP', '(11) 9999-8888', 'carlos.silva@email.com'),
('Dra. Ana Oliveira', '54321-RJ', 'RJ', '(21) 98888-7777', 'ana.oliveira@email.com'),
('Dr. Marcos Souza', '98765-MG', 'MG', '(31) 97777-6666', 'marcos.souza@email.com'),
('Dra. Juliana Costa', '45678-SP', 'SP', '(11) 96666-5555', 'juliana.costa@email.com');

-- Relacionando Médicos e Especialidades
INSERT INTO Medico_Especialidade (id_medico, id_especialidade, principal) VALUES
(1, 1, TRUE),  -- Dr. Carlos - Cardiologia
(2, 3, TRUE),  -- Dra. Ana - Pediatria
(3, 4, TRUE),  -- Dr. Marcos - Ortopedia
(4, 5, TRUE),  -- Dra. Juliana - Ginecologia
(1, 4, FALSE); -- Dr. Carlos também tem Ortopedia (não principal)

-- Inserindo Convênios
INSERT INTO Convenio (nome, registro_ans, telefone) VALUES
('Amil Saúde', '1234567890', '0800 123 456'),
('Unimed', '0987654321', '0800 987 654'),
('Bradesco Saúde', '1122334455', '0800 112 233'),
('SulAmérica', '5566778899', '0800 556 677');

-- Inserindo Pacientes
INSERT INTO Paciente (nome, data_nascimento, sexo, cpf, telefone, email, endereco, cidade, uf) VALUES
('João Pereira', '1985-05-15', 'M', '123.456.789-00', '(11) 95555-4444', 'joao@email.com', 'Rua A, 100', 'São Paulo', 'SP'),
('Maria Santos', '1990-08-20', 'F', '987.654.321-00', '(21) 94444-3333', 'maria@email.com', 'Av. B, 200', 'Rio de Janeiro', 'RJ'),
('Pedro Oliveira', '1978-03-10', 'M', '456.789.123-00', '(31) 93333-2222', 'pedro@email.com', 'Rua C, 300', 'Belo Horizonte', 'MG'),
('Ana Costa', '1995-11-25', 'F', '789.123.456-00', '(11) 92222-1111', 'ana@email.com', 'Av. D, 400', 'São Paulo', 'SP');

-- Vinculando Pacientes a Convênios
INSERT INTO Paciente_Convenio (id_paciente, id_convenio, numero_carteira, validade, titular) VALUES
(1, 1, 'AMIL12345', '2025-12-31', 'João Pereira'),
(2, 2, 'UNI54321', '2024-10-31', 'Maria Santos'),
(3, 3, 'BRD98765', '2025-06-30', 'Pedro Oliveira'),
(4, 1, 'AMIL67890', '2024-12-31', 'Ana Costa');

-- Inserindo Consultas
INSERT INTO Consulta (id_paciente, id_medico, id_convenio, data_hora, duracao, diagnostico, prescricao, status, valor) VALUES
(1, 1, 1, '2023-11-15 09:00:00', 30, 'Hipertensão arterial', 'Manter uso do medicamento prescrito', 'Realizada', 250.00),
(2, 2, 2, '2023-11-16 10:30:00', 30, 'Check-up infantil', 'Vacinação em dia', 'Realizada', 200.00),
(3, 3, 3, '2023-11-17 14:00:00', 40, 'Lombalgia', 'Repouso e fisioterapia', 'Realizada', 300.00),
(4, 4, 1, '2023-11-20 08:00:00', 30, NULL, NULL, 'Agendada', 280.00);

-- Inserindo Tipos de Exame
INSERT INTO Tipo_Exame (nome, descricao, valor_referencia) VALUES
('Hemograma completo', 'Avaliação das células sanguíneas', 80.00),
('Eletrocardiograma', 'Avaliação da atividade elétrica do coração', 120.00),
('Ultrassom abdominal', 'Avaliação de órgãos abdominais', 250.00),
('Raio-X de coluna', 'Avaliação da estrutura óssea da coluna', 150.00);

-- Inserindo Exames
INSERT INTO Exame (id_consulta, id_tipo_exame, data_realizacao, resultado, status) VALUES
(1, 2, '2023-11-15', 'ECG normal', 'Entregue'),
(3, 4, '2023-11-18', 'Desgaste na vértebra L5', 'Entregue'),
(1, 1, '2023-11-16', NULL, 'Realizado'),
(3, 3, NULL, NULL, 'Solicitado');

-- Inserindo Medicamentos
INSERT INTO Medicamento (nome, principio_ativo, tarja) VALUES
('Losartana', 'Losartana potássica', 'Vermelha'),
('Paracetamol', 'Paracetamol', 'Livre'),
('Dipirona', 'Dipirona sódica', 'Livre'),
('Omeprazol', 'Omeprazol', 'Amarela');

-- Inserindo Prescrições
INSERT INTO Prescricao (id_consulta, id_medicamento, posologia, duracao) VALUES
(1, 1, '1 comprimido ao dia', '30 dias'),
(1, 4, '1 comprimido antes do café', '15 dias'),
(2, 2, '5 gotas/kg a cada 6 horas', '7 dias'),
(3, 3, '1 comprimido a cada 8 horas se dor', '5 dias');