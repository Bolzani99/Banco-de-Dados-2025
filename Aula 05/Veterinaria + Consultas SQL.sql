-- Criação do banco de dados
CREATE DATABASE Veterinaria;
USE Veterinaria;

-- Tabela para armazenar os tipos de animais
CREATE TABLE TIPOS_ANIMAIS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL
);

-- Tabela para armazenar os animais
CREATE TABLE ANIMAIS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    ID_TIPO_ANIMAL INT,
    DATA_NASCIMENTO DATE,
    COR VARCHAR(30),
    PESO DECIMAL(5,2),
    ALTURA DECIMAL(5,2),
    FOREIGN KEY (ID_TIPO_ANIMAL) REFERENCES TIPOS_ANIMAIS(ID) ON DELETE CASCADE
);

-- Tabela para armazenar o histórico de vacinação
CREATE TABLE VACINAS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    DATA_APLICACAO DATE,
    ID_ANIMAL INT,
    FOREIGN KEY (ID_ANIMAL) REFERENCES ANIMAIS(ID) ON DELETE CASCADE
);

-- Inserindo alguns tipos de animais como exemplo
INSERT INTO TIPOS_ANIMAIS (NOME) VALUES 
('CANINO'), 
('FELINO'), 
('SUÍNO'), 
('CAPRINO'), 
('EQUINO'), 
('AVE'), 
('RÉPTIL');

-- Inserindo exemplos de animais com novos nomes
INSERT INTO ANIMAIS (NOME, ID_TIPO_ANIMAL, DATA_NASCIMENTO, COR, PESO, ALTURA) VALUES 
('Thor', 1, '2020-01-15', 'Marrom', 30.50, 60.00), 
('Hulk', 2, '2019-05-20', 'Preto', 4.00, 25.00),
('Ted', 1, '2021-03-10', 'Branco', 28.00, 55.00),
('Bella', 2, '2020-07-25', 'Cinza', 3.50, 22.00),
('Zoe', 3, '2018-11-05', 'Rosa', 150.00, 90.00),
('Jake', 4, '2019-02-15', 'Preto e Branco', 70.00, 80.00),
('Caramelo', 5, '2022-06-30', 'Castanho', 500.00, 150.00);

-- Inserindo exemplos de vacinas com novos nomes
INSERT INTO VACINAS (NOME, DATA_APLICACAO, ID_ANIMAL) VALUES 
('Vacina Contra Raiva', '2023-03-10', 1), 
('Vacina Tríplice', '2023-04-15', 2),
('Vacina Antirrábica', '2023-05-20', 3),
('Vacina Polivalente Felina', '2023-06-25', 4),
('Vacina Suína 5 em 1', '2023-07-10', 5),
('Vacina Antiparasitária', '2023-08-05', 6),
('Vacina Equina de Influenza', '2023-09-01', 7);

-- Consulta 1: Quantidade total de animais registrados no sistema
SELECT COUNT(*) AS TOTAL_ANIMAIS FROM ANIMAIS;

-- Consulta 2: Total de vacinas aplicadas registradas no sistema
SELECT COUNT(*) AS TOTAL_VACINAS FROM VACINAS;

-- Consulta 3: Quantidade de animais agrupados por categoria
SELECT 
    TA.NOME AS TIPO_ANIMAL, 
    COUNT(A.ID) AS QUANTIDADE
FROM 
    TIPOS_ANIMAIS TA
LEFT JOIN 
    ANIMAIS A ON TA.ID = A.ID_TIPO_ANIMAL
GROUP BY 
    TA.NOME
ORDER BY 
    QUANTIDADE DESC;

-- Exibindo as tabelas criadas
SHOW TABLES;

SELECT * FROM VACINAS;
SELECT * FROM ANIMAIS;
SELECT * FROM TIPOS_ANIMAIS;