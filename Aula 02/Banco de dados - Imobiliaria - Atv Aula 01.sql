CREATE DATABASE IMOBILIARIA; 
USE IMOBILIARIA;

-- Criação da tabela IMOVEL para armazenar os registros dos imóveis
CREATE TABLE IMOVEL (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Descricao VARCHAR(255),
    Numero_de_quartos INT,
    Valor_de_venda FLOAT
);

-- Inserção de 10 registros na tabela IMOVEL
INSERT INTO IMOVEL (ID, Nome, Descricao, Numero_de_quartos, Valor_de_venda) VALUES
(1, 'Apartamento Centro', 'Apartamento com 2 quartos, próximo ao metrô.', 2, 300000.00),
(2, 'Casa Jardim', 'Casa com 3 quartos e amplo quintal.', 3, 450000.00),
(3, 'Cobertura Vista Mar', 'Cobertura com vista para o mar, 4 quartos.', 4, 1200000.00),
(4, 'Kitnet Universitária', 'Kitnet ideal para estudantes, 1 quarto.', 1, 150000.00),
(5, 'Chácara Verde', 'Chácara com 5 quartos e piscina.', 5, 800000.00),
(6, 'Apartamento Vila Nova', 'Apartamento com 2 quartos e varanda.', 2, 350000.00),
(7, 'Casa de Praia', 'Casa de praia com 3 quartos, a 100 metros da areia.', 3, 600000.00),
(8, 'Flat Luxo', 'Flat de luxo com 1 quarto e serviços inclusos.', 1, 500000.00),
(9, 'Sítio das Flores', 'Sítio com 4 quartos e área para eventos.', 4, 700000.00),
(10, 'Apartamento Novo', 'Apartamento recém construído, 2 quartos.', 2, 400000.00);

-- Seleciona todos os registros da tabela IMOVEL
SELECT * FROM IMOVEL;

-- Seleciona imóveis cujo valor de venda é maior que R$ 500.000,00
SELECT * FROM IMOVEL
WHERE Valor_de_venda > 500000.00;

-- Conta o número de imóveis agrupados pelo número de quartos
SELECT Numero_de_quartos, COUNT(*) AS Total_imoveis
FROM IMOVEL
GROUP BY Numero_de_quartos;