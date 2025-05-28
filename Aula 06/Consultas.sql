USE atividadeSimposio;

-- Tabelas principais
SELECT * FROM Pessoa;
SELECT * FROM Universitario;
SELECT * FROM Tema;
SELECT * FROM Comissao;
SELECT * FROM Minicurso;
SELECT * FROM Simposio;
SELECT * FROM Artigo;
SELECT * FROM Palestra;

-- Tabelas relacionamentos
SELECT * FROM Comissao_Pessoa;
SELECT * FROM Inscrito_Pessoa;
SELECT * FROM Minicurso_Simposio;
SELECT * FROM Artigo_Simposio;
SELECT * FROM Palestra_Simposio;
SELECT * FROM Organizador_Simposio;
SELECT * FROM Autor_Artigo;
SELECT * FROM Inscricao_Minicurso;
SELECT * FROM Inscricao_Palestra;

-- 1) Nome da pessoa e codigo universitario
SELECT 
    P.nome_completo AS nome_pessoa,
    P.cpf AS cpf_pessoa,
    U.codigo_universitario AS codigo_universitario
FROM 
    Pessoa AS P
JOIN 
    Universitario AS U ON P.id = U.id_pessoa
ORDER BY 
    P.nome_completo ASC;

-- 2) Minicursos do simposio 1
SELECT 
    S.id AS id_simposio,
    S.nome AS nome_simposio,
    M.titulo AS titulo_minicurso,
    P.nome_completo AS nome_orador,
    P.cpf AS cpf_orador
FROM 
    Simposio AS S
JOIN 
    Minicurso_Simposio AS MS ON S.id = MS.id_simposio
JOIN 
    Minicurso AS M ON MS.id_minicurso = M.id
JOIN 
    Pessoa AS P ON M.id_orador = P.id
WHERE 
    S.id = 1
ORDER BY 
    S.nome ASC;

-- 3) Minicursos de todos os simposios
SELECT 
    S.id AS id_simposio,
    S.nome AS nome_simposio,
    M.titulo AS titulo_minicurso,
    P.nome_completo AS nome_orador,
    P.cpf AS cpf_orador
FROM 
    Simposio AS S
JOIN 
    Minicurso_Simposio AS MS ON S.id = MS.id_simposio
JOIN 
    Minicurso AS M ON MS.id_minicurso = M.id
JOIN 
    Pessoa AS P ON M.id_orador = P.id
ORDER BY 
    S.id ASC;

-- 4) Participantes e palestras inscritas
SELECT 
    IP.id_pessoa AS id_participante,
    P.nome_completo AS nome_participante,
    IP.id_palestra AS id_palestra,
    PAL.titulo AS titulo_palestra,
    PAL.id_orador AS id_orador
FROM 
    Inscricao_Palestra AS IP
JOIN 
    Pessoa AS P ON IP.id_pessoa = P.id
JOIN 
    Palestra AS PAL ON IP.id_palestra = PAL.id
ORDER BY 
    IP.id_pessoa ASC, P.nome_completo ASC;

-- 5) Quantidade de participantes por simposio
SELECT 
    S.nome AS nome_simposio,
    COUNT(IP.id_pessoa) AS total_inscritos
FROM 
    Simposio AS S
LEFT JOIN 
    Inscrito_Pessoa AS IP ON S.id = IP.id_evento
GROUP BY 
    S.id, S.nome;

-- 6) Quantidade de universitarios por simposio
SELECT 
    S.nome AS nome_simposio,
    COUNT(U.id_pessoa) AS universitarios_inscritos
FROM 
    Simposio AS S
JOIN 
    Inscrito_Pessoa AS IP ON S.id = IP.id_evento
JOIN 
    Universitario AS U ON IP.id_pessoa = U.id_pessoa
GROUP BY 
    S.id, S.nome;

-- 7) Lista de palestrantes
SELECT 
    P.id AS id_palestrante,
    P.nome_completo AS nome_palestrante,
    P.email AS email_palestrante
FROM 
    Pessoa AS P
WHERE 
    P.tipo_pessoa = 'Palestrante';

-- 8) Organizadores dos simposios
SELECT 
    S.nome AS nome_simposio,
    P.nome_completo AS nome_organizador
FROM 
    Organizador_Simposio AS OS
JOIN 
    Pessoa AS P ON OS.id_pessoa = P.id
JOIN 
    Simposio AS S ON OS.id_simposio = S.id
ORDER BY 
    S.nome ASC;

-- 9) Palestras com dados do orador
SELECT 
    PAL.titulo AS titulo_palestra,
    DATE_FORMAT(PAL.data_evento, '%d/%m/%Y') AS data_palestra,
    DATE_FORMAT(PAL.hora_inicio, '%H:%i') AS hora_inicio,
    DATE_FORMAT(PAL.hora_fim, '%H:%i') AS hora_fim,
    P.nome_completo AS nome_orador
FROM 
    Palestra AS PAL
JOIN 
    Pessoa AS P ON PAL.id_orador = P.id
ORDER BY 
    PAL.data_evento ASC, PAL.hora_inicio ASC;

-- 10) Universitarios que tambem sao palestrantes
SELECT 
    P.nome_completo AS nome_pessoa,
    P.cpf AS cpf_pessoa,
    U.codigo_universitario AS codigo_universitario
FROM 
    Pessoa AS P
JOIN 
    Universitario AS U ON P.id = U.id_pessoa
WHERE 
    P.tipo_pessoa = 'Palestrante'
ORDER BY 
    P.nome_completo ASC;

-- Inserts errados

-- Tentando inserir o orador na propria palestra como participante
INSERT INTO Inscricao_Palestra (id_pessoa, id_palestra) VALUES (33, 6);    

-- Tentando inserir o orador na proprio minicurso como participante
INSERT INTO Inscricao_Minicurso (id_pessoa, id_minicurso) VALUES (5, 3);