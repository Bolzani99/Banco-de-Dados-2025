-- Criação do banco de dados
DROP DATABASE IF EXISTS consultorio_medico;
CREATE DATABASE consultorio_medico CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE consultorio_medico;

-- Tabela de Convênios
CREATE TABLE Convenio (
    id_convenio INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    registro_ans VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    site VARCHAR(100),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_convenio),
    INDEX idx_convenio_nome (nome)
) ENGINE=InnoDB;

-- Tabela de Médicos
CREATE TABLE Medico (
    id_medico INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    uf_crm CHAR(2) NOT NULL,
    especialidade_principal VARCHAR(100) NOT NULL,
    especialidades_secundarias VARCHAR(255),
    telefone VARCHAR(20) NOT NULL,
    celular VARCHAR(20),
    email VARCHAR(100),
    data_nascimento DATE,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_medico),
    INDEX idx_medico_nome (nome),
    INDEX idx_medico_especialidade (especialidade_principal)
) ENGINE=InnoDB;

-- Tabela de Pacientes
CREATE TABLE Paciente (
    id_paciente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo ENUM('F', 'M', 'Outro') NOT NULL,
    estado_civil ENUM('Solteiro', 'Casado', 'Divorciado', 'Viúvo', 'Separado', 'União Estável'),
    cpf VARCHAR(14) UNIQUE,
    rg VARCHAR(20) NOT NULL,
    orgao_emissor VARCHAR(20),
    telefone VARCHAR(20) NOT NULL,
    celular VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(255) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep VARCHAR(10),
    nome_mae VARCHAR(255),
    nome_pai VARCHAR(255),
    profissao VARCHAR(100),
    alergias TEXT,
    medicamentos_uso_continuo TEXT,
    observacoes TEXT,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_paciente),
    INDEX idx_paciente_nome (nome),
    INDEX idx_paciente_cpf (cpf),
    INDEX idx_paciente_data_nascimento (data_nascimento)
) ENGINE=InnoDB;

-- Tabela de Relacionamento Paciente-Convênio 
CREATE TABLE Paciente_Convenio (
    id_paciente_convenio INT NOT NULL AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,
    numero_carteira VARCHAR(50) NOT NULL,
    validade DATE,
    titular VARCHAR(100) NOT NULL,
    plano VARCHAR(100),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_paciente_convenio),
    UNIQUE KEY uk_paciente_convenio (id_paciente, id_convenio, numero_carteira),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_convenio) REFERENCES Convenio(id_convenio) ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_paciente_convenio_paciente (id_paciente),
    INDEX idx_paciente_convenio_convenio (id_convenio)
) ENGINE=InnoDB;

-- Tabela de Consultas
CREATE TABLE Consulta (
    id_consulta INT NOT NULL AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_paciente_convenio INT,
    data_hora DATETIME NOT NULL,
    data_hora_fim DATETIME,
    duracao INT DEFAULT 30 COMMENT 'Duração em minutos',
    tipo ENUM('Consulta', 'Retorno', 'Exame', 'Cirurgia', 'Emergência'),
    diagnostico TEXT,
    cid VARCHAR(10) COMMENT 'Código CID-10',
    prescricao TEXT,
    observacoes TEXT,
    status ENUM('Agendada', 'Confirmada', 'Realizada', 'Cancelada', 'Falta') DEFAULT 'Agendada',
    valor DECIMAL(10,2),
    valor_desconto DECIMAL(10,2) DEFAULT 0,
    forma_pagamento ENUM('Dinheiro', 'Cartão', 'Convênio', 'PIX', 'Transferência'),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_consulta),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_paciente_convenio) REFERENCES Paciente_Convenio(id_paciente_convenio) ON UPDATE CASCADE ON DELETE SET NULL,
    INDEX idx_consulta_paciente (id_paciente),
    INDEX idx_consulta_medico (id_medico),
    INDEX idx_consulta_data (data_hora),
    INDEX idx_consulta_status (status)
) ENGINE=InnoDB;

-- Tabela de Tipos de Exames
CREATE TABLE Tipo_Exame (
    id_tipo_exame INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preparo TEXT,
    codigo_tuss VARCHAR(20) COMMENT 'Código TUSS para convênios',
    valor_referencia DECIMAL(10,2),
    tempo_entrega VARCHAR(50) COMMENT 'Prazo para entrega do resultado',
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_tipo_exame),
    INDEX idx_tipo_exame_nome (nome)
) ENGINE=InnoDB;

-- Tabela de Laboratórios
CREATE TABLE Laboratorio (
    id_laboratorio INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    endereco VARCHAR(255),
    responsavel VARCHAR(100),
    cnpj VARCHAR(18) UNIQUE,
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_laboratorio),
    INDEX idx_laboratorio_nome (nome)
) ENGINE=InnoDB;

-- Tabela de Exames Solicitados
CREATE TABLE Exame (
    id_exame INT NOT NULL AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    id_tipo_exame INT NOT NULL,
    id_laboratorio INT,
    data_solicitacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_realizacao DATE,
    data_entrega DATE,
    resultado TEXT,
    observacoes TEXT,
    status ENUM('Solicitado', 'Realizado', 'Entregue', 'Cancelado') DEFAULT 'Solicitado',
    valor DECIMAL(10,2),
    PRIMARY KEY (id_exame),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_tipo_exame) REFERENCES Tipo_Exame(id_tipo_exame) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_laboratorio) REFERENCES Laboratorio(id_laboratorio) ON UPDATE CASCADE ON DELETE SET NULL,
    INDEX idx_exame_consulta (id_consulta),
    INDEX idx_exame_status (status),
    INDEX idx_exame_data_realizacao (data_realizacao)
) ENGINE=InnoDB;

-- Tabela de Medicamentos
CREATE TABLE Medicamento (
    id_medicamento INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100) NOT NULL,
    apresentacao VARCHAR(100),
    laboratorio VARCHAR(100),
    tarja ENUM('Livre', 'Amarela', 'Vermelha', 'Preta'),
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_medicamento),
    INDEX idx_medicamento_nome (nome)
) ENGINE=InnoDB;

-- Tabela de Prescrições
CREATE TABLE Prescricao (
    id_prescricao INT NOT NULL AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    id_medicamento INT NOT NULL,
    posologia TEXT NOT NULL COMMENT 'Como tomar o medicamento',
    quantidade INT COMMENT 'Quantidade de unidades',
    duracao VARCHAR(50) COMMENT 'Tempo de tratamento',
    observacoes TEXT,
    PRIMARY KEY (id_prescricao),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento) ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_prescricao_consulta (id_consulta)
) ENGINE=InnoDB;

-- Tabela de Agendamentos
CREATE TABLE Agendamento (
    id_agendamento INT NOT NULL AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_hora DATETIME NOT NULL,
    duracao INT DEFAULT 30 COMMENT 'Duração em minutos',
    motivo VARCHAR(255),
    status ENUM('Agendado', 'Confirmado', 'Cancelado', 'Realizado', 'Falta') DEFAULT 'Agendado',
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_agendamento),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico) ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_agendamento_paciente (id_paciente),
    INDEX idx_agendamento_medico (id_medico),
    INDEX idx_agendamento_data (data_hora),
    INDEX idx_agendamento_status (status)
) ENGINE=InnoDB;

