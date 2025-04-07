
USE atividadeSimposio;

INSERT INTO Pessoa (cpf, nome_completo, email, telefone, sexo, data_nascimento, tipo_pessoa) VALUES
('222.333.444-55', 'Alan Turing', 'turing@email.com', '(11) 92345-6789', 'M', '1912-06-23', 'Palestrante'),
('333.444.555-66', 'Ada Lovelace', 'lovelace@email.com', '(21) 93456-7890', 'F', '1815-12-10', 'Organizador'),
('444.555.666-77', 'Marie Curie', 'curie@email.com', '(31) 94567-8901', 'F', '1867-11-07', 'Participante'),
('555.666.777-88', 'Nikola Tesla', 'tesla@email.com', '(41) 95678-9012', 'M', '1856-07-10', 'Palestrante'),
('666.777.888-99', 'Rosalind Franklin', 'franklin@email.com', '(51) 96789-0123', 'F', '1920-07-25', 'Organizador'),
('777.888.999-11', 'Carl Sagan', 'sagan@email.com', '(61) 97890-1234', 'M', '1934-11-09', 'Participante'),
('888.999.000-22', 'Sigmund Freud', 'freud@email.com', '(71) 98901-2345', 'M', '1856-05-06', 'Palestrante'),
('999.000.111-33', 'Charles Darwin', 'darwin@email.com', '(81) 99012-3456', 'M', '1809-02-12', 'Participante'),
('111.222.333-44', 'Stephen Hawking', 'hawking@email.com', '(11) 91234-5678', 'M', '1942-01-08', 'Palestrante'),
('222.444.555-99', 'Katherine Johnson', 'johnson@email.com', '(21) 92345-6789', 'F', '1918-08-26', 'Organizador'),
('333.555.666-88', 'Galileu Galilei', 'galilei@email.com', '(31) 93456-7890', 'M', '1564-02-15', 'Participante'),
('444.666.777-77', 'Isaac Newton', 'newton@email.com', '(41) 94567-8901', 'M', '1643-01-04', 'Palestrante'),
('555.777.888-66', 'Leonhard Euler', 'euler@email.com', '(51) 95678-9012', 'M', '1707-04-15', 'Organizador'),
('666.888.999-55', 'Niels Bohr', 'bohr@email.com', '(61) 96789-0123', 'M', '1885-10-07', 'Participante'),
('777.999.000-44', 'Richard Feynman', 'feynman@email.com', '(61) 98765-4321', 'M', '1918-05-11', 'Palestrante'),
('888.000.111-33', 'Alan Kay', 'kay@email.com', '(71) 97654-3210', 'M', '1940-05-17', 'Organizador'),
('999.111.222-22', 'Barbara Liskov', 'liskov@email.com', '(81) 96543-2109', 'F', '1939-11-07', 'Participante'),
('111.333.444-11', 'Claude Shannon', 'shannon@email.com', '(91) 95432-1098', 'M', '1916-04-30', 'Palestrante'),
('222.555.666-00', 'Grace Hopper', 'hopper@email.com', '(11) 94321-0987', 'F', '1906-12-09', 'Organizador'),
('333.666.777-99', 'Linus Torvalds', 'torvalds@email.com', '(21) 93210-9876', 'M', '1969-12-28', 'Participante'),
('444.777.888-88', 'Tim Berners-Lee', 'berners-lee@email.com', '(31) 92109-8765', 'M', '1955-06-08', 'Palestrante'),
('555.888.999-77', 'John von Neumann', 'neumann@email.com', '(41) 91098-7654', 'M', '1903-12-28', 'Organizador'),
('666.999.000-66', 'Donald Knuth', 'knuth@email.com', '(51) 90987-6543', 'M', '1938-01-10', 'Participante'),
('777.000.111-55', 'Edsger Dijkstra', 'dijkstra@email.com', '(61) 89876-5432', 'M', '1930-05-11', 'Palestrante'),
('888.111.222-44', 'Margaret Hamilton', 'hamilton@email.com', '(71) 88765-4321', 'F', '1936-08-17', 'Organizador'),
('999.222.333-33', 'Johannes Kepler', 'kepler@email.com', '(81) 87654-3210', 'M', '1571-12-27', 'Participante'),
('111.333.555-22', 'Emmy Noether', 'noether@email.com', '(91) 86543-2109', 'F', '1882-03-23', 'Organizador'),
('222.444.666-11', 'Michael Faraday', 'faraday@email.com', '(11) 85432-1098', 'M', '1791-09-22', 'Participante'),
('333.555.777-00', 'James Clerk Maxwell', 'maxwell@email.com', '(21) 84321-0987', 'M', '1831-06-13', 'Palestrante'),
('444.666.888-09', 'Henrietta Leavitt', 'leavitt@email.com', '(31) 83210-9876', 'F', '1868-07-04', 'Organizador'),
('555.777.999-08', 'Lise Meitner', 'meitner@email.com', '(41) 82109-8765', 'F', '1878-11-07', 'Participante'),
('666.888.000-07', 'Max Planck', 'planck@email.com', '(51) 81098-7654', 'M', '1858-04-23', 'Palestrante'),
('777.999.111-06', 'Pierre Curie', 'pcurie@email.com', '(61) 80987-6543', 'M', '1859-05-15', 'Organizador'),
('888.000.222-05', 'Dorothy Crowfoot Hodgkin', 'hodgkin@email.com', '(71) 79876-5432', 'F', '1910-05-12', 'Participante'),
('999.111.333-04', 'Alessandro Volta', 'volta@email.com', '(81) 78765-4321', 'M', '1745-02-18', 'Palestrante');

INSERT INTO Universitario (id_pessoa, codigo_universitario) VALUES
(15, 20231256),
(2, 20231257),
(17, 20231258),
(28, 20231259),
(9, 20231260);

INSERT INTO Tema (nome, descricao, area_conhecimento) VALUES
('Banco de Dados', 'Estudo de SGBDs', 'Computação'),
('Redes', 'Infraestrutura de redes', 'Computação'),
('Compiladores', 'Processamento de Linguagens', 'Computação'),
('Inteligência Artificial', 'Estudo de redes neurais e aprendizado de máquina', 'Computação'),
('Cibersegurança', 'Técnicas de proteção e mitigação de ataques', 'Computação'),
('Biologia Molecular', 'Estudo da estrutura e função dos genes', 'Biociências'),
('Astronomia', 'Exploração de corpos celestes e cosmologia', 'Ciências Exatas'),
('Psicologia Cognitiva', 'Compreensão da mente humana e processos de pensamento', 'Ciências Humanas'),
('Física Quântica', 'Estudo do comportamento de partículas subatômicas', 'Física'),
('Matemática Pura', 'Teorias matemáticas abstratas', 'Matemática'),
('Engenharia Aeroespacial', 'Projetos e desenvolvimento de aeronaves e espaçonaves', 'Engenharia');

INSERT INTO Comissao (nome, id_tema, descricao) VALUES
('Comissão de Banco de Dados', 1, 'Responsável por artigos sobre Banco de Dados'),
('Comissão de Redes', 2, 'Responsável por artigos sobre Redes'),
('Comissão de Compiladores', 3, 'Responsável por artigos sobre compiladores'),
('Comissão de Inteligência Artificial', 4, 'Avanços em IA'),
('Comissão de Cibersegurança', 5, 'Segurança da Informação e proteção de dados'),
('Comissão de Biologia Molecular', 6, 'Pesquisas em DNA e genética'),
('Comissão de Astronomia', 7, 'Estudos sobre o universo e astrofísica'),
('Comissão de Psicologia Cognitiva', 8, 'Pesquisa em comportamento e cognição'),
('Comissão de Física Quântica', 9, 'Pesquisas em mecânica quântica'),
('Comissão de Matemática Pura', 10, 'Avanços matemáticos'),
('Comissão de Engenharia Aeroespacial', 11, 'Projetos de aeronaves e foguetes');

INSERT INTO Minicurso (titulo, data_evento, hora_inicio, hora_fim, id_orador, id_comissao) VALUES
('Introdução ao MySQL', '2025-06-10', '10:00:00', '12:00:00', 2, 1),
('Redes Avançadas', '2025-06-12', '14:00:00', '16:00:00', 2, 2),
('Fundamentos de IA', '2025-06-14', '09:00:00', '11:00:00', 5, 3),
('Proteção contra Ataques Cibernéticos', '2025-06-15', '13:00:00', '15:00:00', 6, 4),
('Descobrindo o DNA', '2025-06-16', '14:00:00', '16:00:00', 7, 5),
('Exploração Espacial', '2025-06-17', '10:00:00', '12:00:00', 8, 6),
('Psicologia e Tecnologia', '2025-06-18', '08:00:00', '10:00:00', 9, 7),
('Introdução à Física Quântica', '2025-06-19', '10:00:00', '12:00:00', 25, 9),
('Topologia e Geometria', '2025-06-20', '14:00:00', '16:00:00', 26, 10),
('Exploração Espacial Avançada', '2025-06-21', '09:00:00', '11:00:00', 27, 11);

INSERT INTO Artigo (avaliacao, titulo, data_submissao, data_avaliacao, nota_avaliacao, id_comissao) VALUES
('Aceito', 'Otimização de Queries', '2025-05-01', '2025-05-10', 9, 1),
('Rejeitado', 'Segurança em Redes', '2025-05-03', '2025-05-12', 5, 2),
('Aceito', 'O uso de Redes Neurais na Medicina', '2025-05-05', '2025-05-15', 10, 3),
('Aceito', 'Detecção de Intrusos em Redes', '2025-05-06', '2025-05-16', 8, 4),
('Rejeitado', 'Desafios no Desenvolvimento Web', '2025-05-07', '2025-05-17', 6, 5),
('Aceito', 'A Evolução da Realidade Virtual', '2025-05-08', '2025-05-18', 9, 6),
('Aceito', 'Scrum vs Kanban: Qual o Melhor?', '2025-05-09', '2025-05-19', 9, 7),
('Aceito', 'Teoria das Cordas e suas Implicações', '2025-05-11', '2025-05-20', 9, 9),
('Rejeitado', 'Criptografia Quântica', '2025-05-13', '2025-05-22', 5, 9),
('Aceito', 'Análise de Algoritmos Probabilísticos', '2025-05-15', '2025-05-25', 10, 10),
('Aceito', 'Propulsão para Exploração Espacial', '2025-05-16', '2025-05-26', 8, 11);

INSERT INTO Simposio (nome, descricao, universidade, data_inicio, data_fim, id_orador_principal, local_simposio, capacidade) VALUES
('Simpósio de Tecnologia', 'Evento sobre tecnologia e inovação', 'UFMG', '2025-06-10', '2025-06-15', 2, 'Auditório Principal', 200),
('Simpósio de Física e Matemática', 'Discussões sobre avanços nessas áreas', 'USP', '2025-06-19', '2025-06-22', 25, 'Auditório Central', 250);

INSERT INTO Minicurso_Simposio (id_simposio, id_minicurso) VALUES
(2, 8),  
(2, 9),  
(2, 10);

INSERT INTO Artigo_Simposio (id_simposio, id_artigo) VALUES
(2, 8),
(2, 9),
(2, 10),  
(2, 11);

INSERT INTO Inscrito_Pessoa (id_evento, id_pessoa) VALUES
(2, 25),
(2, 27),
(2, 29),
(2, 31),  
(2, 33),  
(2, 35);

SELECT * FROM Pessoa;
SELECT * FROM Universitario;
SELECT * FROM Tema;
SELECT * FROM Comissao;
SELECT * FROM Minicurso;
SELECT * FROM Simposio;
