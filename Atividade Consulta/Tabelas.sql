CREATE DATABASE consultorio_medico;
USE consultorio_medico;

CREATE TABLE Paciente (
    id_paciente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo ENUM('F', 'M', 'Outro') NOT NULL,
    estado_civil ENUM('Solteiro', 'Casado', 'Divorciado', 'Viúvo', 'Separado') NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    rg VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    endereco VARCHAR(255) NOT NULL,
    alergias TEXT,
    observacoes TEXT,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_paciente)
);

 
CREATE TABLE Convenio (
    id_convenio INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    registro_ans VARCHAR(20),
    telefone VARCHAR(20),
    PRIMARY KEY (id_convenio)
);

-- 3. Tabela de Relacionamento Paciente-Convênio 
CREATE TABLE Paciente_Convenio (
    id_paciente INT NOT NULL,
    id_convenio INT NOT NULL,
    numero_carteira VARCHAR(50),
    validade DATE,
    titular VARCHAR(100),
    PRIMARY KEY (id_paciente, id_convenio),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_convenio) REFERENCES Convenio(id_convenio)
);


CREATE TABLE Medico (
    id_medico INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    especialidade VARCHAR(100),
    telefone VARCHAR(20),
    PRIMARY KEY (id_medico)
);


CREATE TABLE Consulta (
    id_consulta INT NOT NULL AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_hora DATETIME NOT NULL,
    diagnostico TEXT NOT NULL,
    prescricao TEXT,
    observacoes TEXT,
    status ENUM('Agendada', 'Realizada', 'Cancelada', 'Falta') DEFAULT 'Agendada',
    PRIMARY KEY (id_consulta),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);


CREATE TABLE Exame (
    id_exame INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preparo TEXT,
    PRIMARY KEY (id_exame)
);

-- Tabela de Solicitação de Exames
 
CREATE TABLE Consulta_Exame (
    id_consulta_exame INT NOT NULL AUTO_INCREMENT,
    id_consulta INT NOT NULL,
    id_exame INT NOT NULL,
    data_solicitacao DATE NOT NULL,
    data_realizacao DATE,
    resultado TEXT,
    laboratorio VARCHAR(100),
    PRIMARY KEY (id_consulta_exame),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta),
    FOREIGN KEY (id_exame) REFERENCES Exame(id_exame)
);