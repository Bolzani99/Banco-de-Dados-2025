CREATE DATABASE dados_cadastrais;
USE dados_cadastrais;

-- Tabela base de Pessoas 
CREATE TABLE Pessoa(
    pessoa_id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    rg VARCHAR(20) NOT NULL UNIQUE,
    cpf VARCHAR(11) NOT NULL UNIQUE, 
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
    numero VARCHAR(10),
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

-- Tabela de Lotação 
CREATE TABLE Lotacao(
    lotacao_id INT NOT NULL AUTO_INCREMENT,
    pessoa_id INT NOT NULL,
    departamento_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
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

CREATE TABLE Pessoa_Endereco (
    pessoa_id INT NOT NULL,
    endereco_id INT NOT NULL,
    tipo_endereco ENUM('Residencial', 'Comercial', 'Outro') NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_pessoa_endereco PRIMARY KEY (pessoa_id, endereco_id),
    CONSTRAINT fk_pe_pessoa FOREIGN KEY (pessoa_id) REFERENCES Pessoa(pessoa_id),
    CONSTRAINT fk_pe_endereco FOREIGN KEY (endereco_id) REFERENCES Endereco(endereco_id)
);

-- Triggers para validação de dependentes
DELIMITER //
CREATE TRIGGER trg_valida_dependente_insert
BEFORE INSERT ON Dependente
FOR EACH ROW
BEGIN
    
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.pessoa_id) != 'Dependente' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O dependente deve ser do tipo "Dependente"';
    END IF;
    
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.titular_id) != 'Titular' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O titular deve ser do tipo "Titular"';
    END IF;
    
    -- Comparar IDs de pessoa (titular vs. dependente)
    IF NEW.pessoa_id = NEW.titular_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Uma pessoa não pode ser dependente de si mesma';
    END IF;
END//


DELIMITER //

CREATE TRIGGER trg_valida_dependente_update
BEFORE UPDATE ON Dependente
FOR EACH ROW
BEGIN
   
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.pessoa_id) != 'Dependente' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O dependente deve ser do tipo "Dependente"';
    END IF;
    
    IF (SELECT tipo FROM Pessoa WHERE pessoa_id = NEW.titular_id) != 'Titular' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O titular deve ser do tipo "Titular"';
    END IF;
    
    IF NEW.pessoa_id = NEW.titular_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Uma pessoa não pode ser dependente de si mesma';
    END IF;
END//

DELIMITER ;

DELIMITER //

-- Verifica se o cpf tem 11 dígitos numéricos
CREATE TRIGGER trg_valida_cpf
BEFORE INSERT ON Pessoa
FOR EACH ROW
BEGIN
    
    IF NEW.cpf NOT REGEXP '^[0-9]{11}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'CPF deve conter exatamente 11 dígitos numéricos';
    END IF;
END//

DELIMITER ;


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

DELIMITER //

-- Função para retornar o id dos dependentes
CREATE FUNCTION GetIdDependente(titular_id INT) 
RETURNS VARCHAR(255)  -- Retorna lista de IDs separados por vírgula
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE dependentes_ids VARCHAR(255);
    
    SELECT GROUP_CONCAT(pessoa_id SEPARATOR ',') 
    INTO dependentes_ids
    FROM Dependente
    WHERE titular_id = titular_id;
    
    RETURN dependentes_ids;
END //

DELIMITER ;

-- Índices para melhorar performance
CREATE INDEX idx_pessoa_cpf ON Pessoa(cpf);
CREATE INDEX idx_pessoa_nome_sobrenome ON Pessoa(nome, sobrenome);
CREATE INDEX idx_cadastro_matricula ON Cadastro(matricula);
CREATE INDEX fk_cadastro_pessoa_idx ON Cadastro(pessoa_id);
CREATE INDEX fk_co_pessoa_idx ON Cargos_Ocupados(pessoa_id);
CREATE INDEX fk_co_cargo_idx ON Cargos_Ocupados(cargo_id);
CREATE INDEX fk_lotacao_pessoa_idx ON Lotacao(pessoa_id);
CREATE INDEX fk_lotacao_departamento_idx ON Lotacao(departamento_id);