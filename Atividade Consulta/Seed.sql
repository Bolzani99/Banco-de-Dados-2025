-- Inserindo convênios
INSERT INTO Convenio (nome, registro_ans, telefone) VALUES
('Unimed', '123456', '0800-123456'),
('Amil', '654321', '0800-654321'),
('Bradesco Saúde', '987654', '0800-987654');

-- Inserindo médicos
INSERT INTO Medico (nome, crm, especialidade, telefone) VALUES
('Dr. Carlos Mendes', 'CRM/SP 123456', 'Cardiologia', '(11) 9999-1111'),
('Dra. Juliana Almeida', 'CRM/SP 654321', 'Clínica Geral', '(11) 9999-2222'),
('Dr. Roberto Santos', 'CRM/SP 987654', 'Gastroenterologia', '(11) 9999-3333');

-- Inserindo pacientes 
INSERT INTO Paciente (nome, data_nascimento, sexo, estado_civil, cpf, rg, telefone, email, endereco, alergias) VALUES
('Maria Silva', '1985-05-15', 'F', 'Casado', '123.456.789-00', '123456789', '(11) 9999-8888', 'maria@email.com', 'Rua das Flores, 123 - São Paulo/SP', 'Penicilina'),
('João Santos', '1990-08-22', 'M', 'Solteiro', '987.654.321-00', '987654321', '(11) 7777-6666', 'joao@email.com', 'Av. Paulista, 1000 - São Paulo/SP', NULL),
('Ana Oliveira', '1978-11-30', 'F', 'Divorciado', '456.789.123-00', '456789123', '(11) 5555-4444', 'ana@email.com', 'Rua XV de Novembro, 50 - São Paulo/SP', 'Dipirona');

-- Associando pacientes a convênios
INSERT INTO Paciente_Convenio (id_paciente, id_convenio, numero_carteira, validade, titular) VALUES
(1, 1, 'UNI123456', '2024-12-31', 'Maria Silva'),
(2, 2, 'AMIL654321', '2023-06-30', 'João Santos'),
(3, 3, 'BRD987654', '2023-12-31', 'Ana Oliveira');

-- Inserindo exames padrão
INSERT INTO Exame (nome, descricao, preparo) VALUES
('Hemograma completo', 'Avaliação das células sanguíneas', 'Jejum de 4 horas'),
('Eletrocardiograma', 'Avaliação da atividade elétrica do coração', 'Não fumar 2 horas antes'),
('Endoscopia digestiva', 'Exame do trato digestivo superior', 'Jejum de 8 horas'),
('Ultrassonografia abdominal', 'Avaliação de órgãos abdominais', 'Jejum de 6 horas');

-- Inserindo consultas 
INSERT INTO Consulta (id_paciente, id_medico, data_hora, diagnostico, prescricao, status) VALUES
(1, 1, '2023-01-10 09:00:00', 'Hipertensão arterial estágio 1', 'Losartana 50mg 1x/dia', 'Realizada'),
(2, 2, '2023-02-15 14:30:00', 'Resfriado comum', 'Repouso e hidratação', 'Realizada'),
(1, 1, '2023-03-20 10:15:00', 'Acompanhamento hipertensão', 'Manter medicação', 'Realizada'),
(3, 3, '2023-04-05 11:00:00', 'Dor abdominal - suspeita de gastrite', 'Omeprazol 20mg 1x/dia', 'Realizada');

-- Inserindo exames solicitados
INSERT INTO Consulta_Exame (id_consulta, id_exame, data_solicitacao, data_realizacao, laboratorio) VALUES
(1, 1, '2023-01-10', '2023-01-11', 'Lab Exame'),
(1, 2, '2023-01-10', '2023-01-12', 'Cardio Lab'),
(3, 1, '2023-03-20', '2023-03-21', 'Lab Exame'),
(4, 3, '2023-04-05', '2023-04-10', 'Gastro Center'),
(4, 4, '2023-04-05', '2023-04-10', 'Imagem Médica');