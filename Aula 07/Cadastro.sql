CREATE DATABASE dados_cadastrais;

USE dados_cadastrais;

CREATE TABLE Pessoa(
	cliente_id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	sobrenome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    nacionalidade VARCHAR(255) NOT NULL,
    sexo ENUM('M','F') NOT NULL,
	estado_civil ENUM('solteiro','casado','divorciado','viuvo'),
    rg VARCHAR(20) NOT NULL UNIQUE,
    cpf VARCHAR(17) NOT NULL UNIQUE,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_pessoa PRIMARY KEY (cliente_id) 
);

CREATE TABLE Cadastro(
	cadastro_id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
	matricula VARCHAR(20) NOT NULL,
    data_admissao DATE NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cadastro PRIMARY KEY (cadastro_id),
    CONSTRAINT fk_cadastro_pessoa FOREIGN KEY (cliente_id) REFERENCES Pessoa (cliente_id)
);

CREATE TABLE Endereco(
	endereco_id INT NOT NULL AUTO_INCREMENT,
	cliente_id INT NOT NULL,
    rua VARCHAR(100) NOT NULL,
    numero INT,
    complemento VARCHAR(100),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_endereco PRIMARY KEY (endereco_id),
    CONSTRAINT fk_endereco_pessoa FOREIGN KEY (cliente_id) REFERENCES Pessoa (cliente_id)
);

CREATE TABLE Cargos_Ocupados(
	cargo_id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cargos PRIMARY KEY (cargo_id),
    CONSTRAINT fk_cargos_pessoa FOREIGN KEY (cliente_id) REFERENCES Pessoa (cliente_id)
);

CREATE TABLE Departamento_Lotacao(
	lotacao_id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_lotacao PRIMARY KEY (lotacao_id),
    CONSTRAINT fk_lotacao_pessoa FOREIGN KEY (cliente_id) REFERENCES Pessoa (cliente_id)
);

CREATE TABLE Dependente(
	cliente_id INT NOT NULL,
    titular_id INT NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_dependente PRIMARY KEY (cliente_id),
    CONSTRAINT fk_dependente_pessoa FOREIGN KEY (cliente_id) REFERENCES Pessoa (cliente_id),
    CONSTRAINT fk_dependente_titular FOREIGN KEY (titular_id) REFERENCES Pessoa (cliente_id)
);