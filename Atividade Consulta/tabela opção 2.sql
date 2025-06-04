-- Criação do banco de dados
DROP DATABASE IF EXISTS consultorio_medico;
CREATE DATABASE consultorio_medico CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE consultorio_medico;

-- Tabela de Especialidades Médicas
CREATE TABLE Especialidade (
    id_especialidade INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    PRIMARY KEY (id_especialidade)
) ENGINE=InnoDB;

-- Tabela de Médicos
CREATE TABLE Medico (
    id_medico INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    uf_crm CHAR(2) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_medico),
    INDEX idx_medico_nome (nome)
) ENGINE=InnoDB;

-- Tabela de Relacionamento Médico-Especialidade
CREATE TABLE Medico_Especialidade (
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    principal BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_medico, id_especialidade),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico) ON DELETE CASCADE,
    FOREIGN KEY (id_especialidade) REFERENCES Especialidade(id_especialidade) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Pacientes
CREATE TABLE Paciente (
    id_paciente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo ENUM('F', 'M', 'Outro') NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    uf CHAR(2),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id_paciente),
    INDEX idx_paciente_nome (nome)
) ENGINE=InnoDB;

-- Tabela de Convênios
CREATE TABLE Convenio (
    id_convenio INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    registro_ans VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_convenio)
) ENGINE=InnoDB;

-- Tabela de Paciente-Convênio
CREATE TABLE Paciente_Convenio (
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,
    numero_carteira VARCHAR(50) NOT NULL,
    validade DATE,
    titular VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_paciente, id_convenio, numero_carteira),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente) ON DELETE CASCADE,
    FOREIGN KEY (id_convenio) REFERENCES Convenio(id_convenio) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de Consultas
CREATE TABLE Consulta (
    id_consulta INT NOT NULL AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_convenio INT,
    data_hora DATETIME NOT NULL,
    duracao INT DEFAULT 30 COMMENT 'Minutos',
    diagnostico TEXT,
    prescricao TEXT,
    status ENUM('Agendada', 'Confirmada', 'Realizada', 'Cancelada', 'Falta') DEFAULT 'Agendada',
    valor DECIMAL(10,2),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_consulta),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico),
    FOREIGN KEY (id_convenio) REFERENCES Convenio(id_convenio),
    INDEX idx_consulta_data (data_hora),
    INDEX idx_consulta_status (status)
) ENGINE=InnoDB;

-- Tabela de Tipos de Exame
CREATE TABLE Tipo_Exame (
    id_tipo_exame INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL UNIQUE,
    descricao TEXT,
    valor_referencia DECIMAL(10,2),
    PRIMARY KEY (id_tipo_exame)
) ENGINE=InnoDB;

-- Tabela de Exames
CREATE TABLE Exame (
    id_exame INT NOT NULL AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    id_tipo_exame INT NOT NULL,
    data_realizacao DATE,
    resultado TEXT,
    status ENUM('Solicitado', 'Realizado', 'Entregue', 'Cancelado') DEFAULT 'Solicitado',
    PRIMARY KEY (id_exame),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta),
    FOREIGN KEY (id_tipo_exame) REFERENCES Tipo_Exame(id_tipo_exame)
) ENGINE=InnoDB;

-- Tabela de Medicamentos
CREATE TABLE Medicamento (
    id_medicamento INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    principio_ativo VARCHAR(100) NOT NULL,
    tarja ENUM('Livre', 'Amarela', 'Vermelha', 'Preta'),
    PRIMARY KEY (id_medicamento)
) ENGINE=InnoDB;

-- Tabela de Prescrições
CREATE TABLE Prescricao (
    id_prescricao INT NOT NULL AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    id_medicamento INT NOT NULL,
    posologia TEXT NOT NULL,
    duracao VARCHAR(50),
    PRIMARY KEY (id_prescricao),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento)
) ENGINE=InnoDB;