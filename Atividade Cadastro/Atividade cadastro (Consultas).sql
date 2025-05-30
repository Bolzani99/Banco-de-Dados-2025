USE dados_cadastrais;


-- 1. LISTA COMPLETA DE PESSOAS
SELECT 
    p.pessoa_id,
    CONCAT(p.nome, ' ', p.sobrenome) AS nome_completo,
    CONCAT(SUBSTRING(p.cpf, 1, 3), '.', SUBSTRING(p.cpf, 4, 3), '.', SUBSTRING(p.cpf, 7, 3), '-', SUBSTRING(p.cpf, 10, 2)) AS cpf_formatado,
    p.data_nascimento,
    TIMESTAMPDIFF(YEAR, p.data_nascimento, CURDATE()) AS idade,
    p.sexo,
    p.estado_civil,
    p.tipo
FROM Pessoa p
ORDER BY p.tipo DESC, p.nome;

-- 2. TITULARES COM DEPENDENTES
SELECT 
    t.nome AS titular,
    d.nome AS dependente,
    dep.parentesco,
    TIMESTAMPDIFF(YEAR, d.data_nascimento, CURDATE()) AS idade_dependente
FROM Dependente dep
JOIN Pessoa t ON dep.titular_id = t.pessoa_id
JOIN Pessoa d ON dep.pessoa_id = d.pessoa_id
ORDER BY t.nome, d.nome;

-- 3. COLABORADORES ATIVOS
SELECT 
    CONCAT(p.nome, ' ', p.sobrenome) AS colaborador,
    c.nome AS cargo,
    d.nome AS departamento,
    ca.matricula,
    DATE_FORMAT(ca.data_admissao, '%d/%m/%Y') AS admissao
FROM Pessoa p
JOIN Cadastro ca ON p.pessoa_id = ca.pessoa_id
JOIN Cargos_Ocupados co ON p.pessoa_id = co.pessoa_id AND co.data_fim IS NULL
JOIN Cargo c ON co.cargo_id = c.cargo_id
JOIN Lotacao l ON p.pessoa_id = l.pessoa_id AND l.data_fim IS NULL
JOIN Departamento d ON l.departamento_id = d.departamento_id
WHERE p.tipo = 'Titular'
ORDER BY d.nome, p.nome;

-- 4. ENDEREÇOS CADASTRADOS
SELECT 
    CONCAT(p.nome, ' ', p.sobrenome) AS pessoa,
    pe.tipo_endereco,
    CONCAT(e.rua, ', ', e.numero, IF(e.complemento IS NOT NULL, CONCAT(' - ', e.complemento), ''), ', ', e.bairro) AS endereco,
    CONCAT(e.cidade, '/', e.estado) AS cidade_uf,
    e.cep
FROM Pessoa p
JOIN Pessoa_Endereco pe ON p.pessoa_id = pe.pessoa_id
JOIN Endereco e ON pe.endereco_id = e.endereco_id
ORDER BY p.nome, pe.tipo_endereco;

