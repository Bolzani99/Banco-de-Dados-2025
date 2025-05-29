CREATE DATABASE dados_cadastrais;
USE dados_cadastrais;

-- Tabela base de Pessoas (CPF mantido como estava originalmente)
CREATE TABLE Pessoa(
    pessoa_id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    rg VARCHAR(20) NOT NULL UNIQUE,
    cpf VARCHAR(17) NOT NULL UNIQUE,  -- Mantido como VARCHAR(17) conforme original
    data_nascimento DATE NOT NULL,
    nacionalidade VARCHAR(255) NOT NULL,
    sexo ENUM('M','F') NOT NULL,
    estado_civil ENUM('Solteiro','Casado','Divorciado','Viuvo') NOT NULL,
    tipo ENUM('Titular','Dependente') NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_pessoa PRIMARY KEY (pessoa_id)
);

-- Tabela de Endereços
CREATE TABLE Endereco(
    endereco_id INT NOT NULL AUTO_INCREMENT,
    rua VARCHAR(100) NOT NULL,
    numero INT,
    complemento VARCHAR(100),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_endereco PRIMARY KEY (endereco_id)
);

-- Tabela de Cargos
CREATE TABLE Cargo(
    cargo_id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    nivel VARCHAR(50),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cargo PRIMARY KEY (cargo_id)
);

-- Tabela de Departamentos
CREATE TABLE Departamento(
    departamento_id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sigla VARCHAR(10),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_departamento PRIMARY KEY (departamento_id)
);

-- Tabela de Cadastro (Matrícula)
CREATE TABLE Cadastro(
    cadastro_id INT NOT NULL AUTO_INCREMENT,
    pessoa_id INT NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    data_admissao DATE NOT NULL,
    data_demissao DATE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cadastro PRIMARY KEY (cadastro_id),
    CONSTRAINT fk_cadastro_pessoa FOREIGN KEY (pessoa_id) REFERENCES Pessoa(pessoa_id)
);

-- Tabela de Cargos Ocupados
CREATE TABLE Cargos_Ocupados(
    cargo_ocupado_id INT NOT NULL AUTO_INCREMENT,
    pessoa_id INT NOT NULL,
    cargo_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cargos_ocupados PRIMARY KEY (cargo_ocupado_id),
    CONSTRAINT fk_co_pessoa FOREIGN KEY (pessoa_id) REFERENCES Pessoa(pessoa_id),
    CONSTRAINT fk_co_cargo FOREIGN KEY (cargo_id) REFERENCES Cargo(cargo_id)
);

-- Tabela de Lotação (com TIMESTAMP corrigido)
CREATE TABLE Lotacao(
    lotacao_id INT NOT NULL AUTO_INCREMENT,
    pessoa_id INT NOT NULL,
    departamento_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Corrigido
    CONSTRAINT pk_lotacao PRIMARY KEY (lotacao_id),
    CONSTRAINT fk_lotacao_pessoa FOREIGN KEY (pessoa_id) REFERENCES Pessoa(pessoa_id),
    CONSTRAINT fk_lotacao_departamento FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id)
);

-- Tabela de Dependentes com triggers
CREATE TABLE Dependente(
    dependente_id INT NOT NULL AUTO_INCREMENT,
    titular_id INT NOT NULL,
    pessoa_id INT NOT NULL,  -- Adicionado
    parentesco VARCHAR(50) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_dependente PRIMARY KEY (dependente_id),
    CONSTRAINT fk_dependente_pessoa FOREIGN KEY (pessoa_id) REFERENCES Pessoa(pessoa_id),
    CONSTRAINT fk_dependente_titular FOREIGN KEY (titular_id) REFERENCES Pessoa(pessoa_id),
    CONSTRAINT uk_dependente_pessoa UNIQUE (pessoa_id)  -- Uma pessoa só pode ser dependente uma vez
);

-- Triggers para validação de dependentes
DELIMITER //

CREATE TRIGGER trg_valida_dependente_insert
BEFORE INSERT ON Dependente
FOR EACH ROW
BEGIN
    -- Verifica se o dependente é do tipo 'Dependente'
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.dependente_id) != 'Dependente' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O dependente deve ser do tipo "Dependente"';
    END IF;
    
    -- Verifica se o titular é do tipo 'Titular'
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.titular_id) != 'Titular' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O titular deve ser do tipo "Titular"';
    END IF;
    
    -- Evita que uma pessoa seja dependente de si mesma
    IF NEW.dependente_id = NEW.titular_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Uma pessoa não pode ser dependente de si mesma';
    END IF;
END//

CREATE TRIGGER trg_valida_dependente_update
BEFORE UPDATE ON Dependente
FOR EACH ROW
BEGIN
    -- Verifica se o dependente é do tipo 'Dependente'
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.dependente_id) != 'Dependente' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O dependente deve ser do tipo "Dependente"';
    END IF;
    
    -- Verifica se o titular é do tipo 'Titular'
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.titular_id) != 'Titular' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O titular deve ser do tipo "Titular"';
    END IF;
    
    -- Evita que uma pessoa seja dependente de si mesma
    IF NEW.dependente_id = NEW.titular_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Uma pessoa não pode ser dependente de si mesma';
    END IF;
END//

DELIMITER ;

-- View para CPF formatado (versão original)
CREATE VIEW vw_cpf_formatado AS
SELECT 
    pessoa_id,
    nome,
    sobrenome,
    CONCAT(SUBSTRING(cpf, 1, 3), '.', 
           SUBSTRING(cpf, 4, 3), '.', 
           SUBSTRING(cpf, 7, 3), '-', 
           SUBSTRING(cpf, 10, 2)) AS cpf_formatado
FROM Pessoa;

-- Índices para melhorar performance
CREATE INDEX idx_pessoa_cpf ON Pessoa(cpf);
CREATE INDEX idx_pessoa_nome_sobrenome ON Pessoa(nome, sobrenome);
CREATE INDEX idx_cadastro_matricula ON Cadastro(matricula);