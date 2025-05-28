USE atividadeSimposio;
-- CONSULTAS

-- Nome da pessoa e codigo universitario
SELECT P.nome_completo AS Nome, P.cpf AS Cpf , UN.codigo_universitario AS Código_Universitario
FROM
	Universitario AS UN,
	Pessoa AS P
WHERE
	P.id = UN.id_pessoa
ORDER BY
	P.nome_completo ASC;

-- Minicurso no simposio 1    
SELECT S.id, S.nome,  M.titulo AS minicurso_titulo, P.nome_completo AS nome_orador_minicurso, P.cpf 
FROM
	Simposio AS S
INNER JOIN
	Minicurso_Simposio AS MS ON S.id = MS.id_simposio 
INNER JOIN 
    Minicurso AS M ON MS.id_minicurso = M.id
INNER JOIN
    Pessoa AS P ON M.id_orador = P.id
WHERE 
    S.id = 1
ORDER BY
    S.nome ASC;