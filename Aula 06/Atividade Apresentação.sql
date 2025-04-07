CREATE DATABASE IF NOT EXISTS atividadeSimposio;

USE atividadeSimposio;

CREATE TABLE Pessoa(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	cpf VARCHAR(14) NOT NULL UNIQUE,
	nome_completo VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	telefone VARCHAR(15) NOT NULL UNIQUE,
	sexo ENUM('M','F') NOT NULL,
	data_nascimento DATE NOT NULL, 
	tipo_pessoa ENUM('Participante', 'Palestrante', 'Organizador', 'Indefinido') DEFAULT 'Indefinido' NOT NULL 
);

CREATE TABLE Universitario (
	id_pessoa INT NOT NULL PRIMARY KEY,
	codigo_universitario INT NOT NULL UNIQUE,
	CONSTRAINT Fk_universitario_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id)
);

CREATE TABLE Tema(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	descricao TEXT NOT NULL,
	area_conhecimento VARCHAR(255) NOT NULL, 
	data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Comissao(
	id  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	id_tema INT NOT NULL,
	data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	descricao TEXT,
	CONSTRAINT Fk_comissao_tema FOREIGN KEY (id_tema) REFERENCES Tema(id)
);

CREATE TABLE Minicurso(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(255) NOT NULL,
	data_evento DATE NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fim TIME NOT NULL,
	id_orador INT NOT NULL,
	id_comissao  INT NOT NULL,
	CONSTRAINT Fk_orador_minicurso FOREIGN KEY (id_orador) REFERENCES Pessoa(id),
	CONSTRAINT Fk_minicurso_comissao FOREIGN KEY (id_comissao) REFERENCES Comissao(id)
);

CREATE TABLE Artigo(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	avaliacao VARCHAR(255) NOT NULL,
	titulo VARCHAR(255) NOT NULL,
	data_submissao DATE NOT NULL,
	data_avaliacao DATE,
	nota_avaliacao INT NOT NULL,
	id_comissao  INT NOT NULL,
	CONSTRAINT Fk_artigo_comissao FOREIGN KEY (id_comissao) REFERENCES Comissao(id)
);

CREATE TABLE Palestra(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(255) NOT NULL,
	data_evento DATE NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fim TIME NOT NULL,
	id_orador INT NOT NULL,
	id_comissao  INT NOT NULL,
	CONSTRAINT Fk_orador_palestra FOREIGN KEY (id_orador) REFERENCES Pessoa(id),
	CONSTRAINT Fk_palestra_comissao FOREIGN KEY (id_comissao) REFERENCES Comissao(id)
);

CREATE TABLE Simposio(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	descricao TEXT,
	universidade VARCHAR(255) NOT NULL,
	data_inicio DATE NOT NULL,
	data_fim DATE NOT NULL,
	id_orador_principal INT NOT NULL,
	local_simposio VARCHAR(255) NOT NULL,
	capacidade INT,
	CONSTRAINT Fk_orador_simposio FOREIGN KEY (id_orador_principal) REFERENCES Pessoa(id)
);

-- Tabelas de Relacionamentos
CREATE TABLE Comissao_Pessoa(
	id_pessoa INT NOT NULL,
	id_comissao  INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_comissao),
	CONSTRAINT Fk_comissao_id_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_comissao_id_comissao FOREIGN KEY (id_comissao) REFERENCES Comissao(id)
);

CREATE TABLE Inscrito_Pessoa(
	id_evento INT NOT NULL,
	id_pessoa INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_evento),
	CONSTRAINT Fk_inscrito_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_inscrito_simposio FOREIGN KEY (id_evento) REFERENCES Simposio(id)
);

CREATE TABLE Minicurso_Simposio(
	id_simposio INT NOT NULL,
	id_minicurso INT NOT NULL,
	PRIMARY KEY (id_simposio, id_minicurso),
	CONSTRAINT Fk_minicurso_simposio FOREIGN KEY (id_simposio) REFERENCES Simposio(id),
	CONSTRAINT Fk_simposio_minicurso FOREIGN KEY (id_minicurso) REFERENCES Minicurso(id)
);

CREATE TABLE Artigo_Simposio(
	id_simposio INT NOT NULL,
	id_artigo INT NOT NULL,
	PRIMARY KEY (id_simposio, id_artigo),
	CONSTRAINT Fk_artigo_simposio FOREIGN KEY (id_simposio) REFERENCES Simposio(id),
	CONSTRAINT Fk_simposio_artigo FOREIGN KEY (id_artigo) REFERENCES Artigo(id)
);

CREATE TABLE Organizador_Simposio (
	id_pessoa INT NOT NULL,
	id_simposio INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_simposio),
	CONSTRAINT Fk_organizador_simposio_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_organizador_simposio_simposio FOREIGN KEY (id_simposio) REFERENCES Simposio(id)
);

CREATE TABLE Autor_Artigo(
	id_pessoa INT NOT NULL,
	id_artigo INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_artigo),
	CONSTRAINT Fk_autor_artigo_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_autor_artigo_artigo  FOREIGN KEY (id_artigo) REFERENCES Artigo(id)
);

CREATE TABLE Inscricao_Minicurso(
	id_pessoa INT NOT NULL,
	id_minicurso INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_minicurso),
	CONSTRAINT Fk_inscricao_minicurso_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_inscricao_minicurso_minicurso FOREIGN KEY (id_minicurso) REFERENCES Minicurso(id)
);

CREATE TABLE Inscricao_Palestra(
	id_pessoa INT NOT NULL,
	id_palestra INT NOT NULL,
	PRIMARY KEY (id_pessoa, id_palestra),
	CONSTRAINT Fk_inscricao_palestra_pessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id),
	CONSTRAINT Fk_inscricao_palestra_palestra FOREIGN KEY (id_palestra) REFERENCES Palestra(id)
);