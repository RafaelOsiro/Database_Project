/* 
PRÓ-REITORIA ACADÊMICA
ESCOLA DE EDUCAÇÃO, TECNOLOGIA E COMUNICAÇÃO
CURSO DE CIÊNCIA DA COMPUTAÇÃO

TRABALHO DE CONCLUSÃO DE DISCIPLINA PARTE 3
LABORATÓRIO DE BANCO DE DADOS GPE02M0234

AUTORES:
FELIPE SOUZA MARRA - UC20101381
RAFAEL RIKI OGAWA OSIRO - UC21100716

ORIENTADORA: JOYCE SIQUEIRA

BRASÍLIA - DF
2021
*/

-- INSERINDO DADOS NA TABELA CARGOS --
SELECT * FROM cargos; -- OK
INSERT INTO cargos (descricao) VALUES 
('Atendente'),
('Gerente'),
('Servicos Gerais');
SELECT * FROM cargos;

DELETE FROM cargos WHERE id = 4;
DELETE FROM cargos WHERE id = 5;
DELETE FROM cargos WHERE id = 6;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA TELEFONES --
SELECT * FROM telefones; -- OK
INSERT INTO telefones (ddd, telefone) VALUES
(68, 987451235),
(11, 34501928),
(21, 32458769),
(61, 987125489),
(62, 32098716),
(68, 997071602),
(91, 993994202),
(51, 995541827),
(92, 986821186),
(63, 982572403);
SELECT * FROM telefones;

-- ALTERANDO TELEFONE COM PROBLEMAS -- -- OK
UPDATE telefones SET telefone = 32234869 WHERE ID = 1;
UPDATE telefones SET telefone = 59701000 WHERE ID = 2;
UPDATE telefones SET telefone = 21067800 WHERE ID = 3;
UPDATE telefones SET telefone = 33408696 WHERE ID = 4;
UPDATE telefones SET telefone = 32413725 WHERE ID = 5;
SELECT * FROM telefones;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA ENDERECOS --
SELECT * FROM enderecos;
INSERT INTO enderecos (logradouro, bairro, cidade, uf, cep) VALUES
('Rua Camburiu', 'Vilage Wilde Maciel', 'Rio Branco', 'AC', '69918496'),
('Avenida Jaceguava', 'Balneário São José', 'São Paulo', 'SP','04870425'),
('Rua Itabaiana', 'Grajaú', 'Rio de Janeiro', 'RJ', '20251055'),
('EQN 315/316', 'Asa Norte', 'Brasília', 'DF','70774400'),
('Rua T-53', 'Setor Marista', 'Goiânia', 'GO',  '74150310'),
('Rua Órion', 'Morada do Sol', 'Rio Branco', 'AC', '69901103'),
('Passagem São Jorge', 'Atalaia', 'Ananindeua', 'PA', '67013843'),
('Rua Adylo João Sperotto', 'Feitoria', 'São Leopoldo', 'RS', '93048340'),
('Rua Serra Divina', 'Colônia Terra Nova', 'Manaus', 'AM', '69015473'),
('Rua 20', 'Jardim Aureny III (Taquaralto)', 'Palmas', 'TO','77062074');
SELECT * FROM enderecos;

-- ALTERANDO ENDERECO COM PROBLEMA --
UPDATE enderecos SET logradouro = 'Avenida Professor Hermann Von Ihering', bairro = 'Jardim Casa Grande', cep = '04870901' WHERE ID = 2;
SELECT * FROM enderecos;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA CLIENTES --
SELECT * FROM clientes;
INSERT INTO clientes (endereco, numero, telefone) VALUES
(1, 87, 1),
(2, 6567, 2),
(3, 74, 3),
(4, 'AE', 4),
(5, 30, 5),
(6, 352, 6),
(7, 874, 7),
(8, 786, 8),
(9, 216, 9),
(10, 665, 10);
SELECT * FROM clientes;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA FORMAS_PAGAMENTO --
SELECT * FROM formas_pagamento;
INSERT INTO formas_pagamento (descricao, taxas) VALUES
('A vista', 0),
('Boleto Bancário', 2.00),
('Debito - Visa', 1.39),
('Debito - Master', 1.39),
('Debito - Elo', 1.79);
SELECT * FROM formas_pagamento;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA FUNCIONARIOS --
SELECT * FROM funcionarios;
INSERT INTO funcionarios (matricula, nome, cargo) VALUES
(12379684, 'Noémi Castelo Branco Doutis', 1),
(67841, 'Ema Castelo Branco Frias', 2),
(163278612, 'Dominic Grangeia Picão', 3),
(273984, 'Heitor Coelho Carreiro', 1);
SELECT * FROM funcionarios;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA VEICULOS --
SELECT * FROM veiculos;
INSERT INTO veiculos (marca, modelo, placa, estado) VALUES
('Man', 'TGX', 'NAF8604', 'AC'),
('Volvo', 'FH16', 'BNK3936', 'SP'),
('Scania', 'Next Gen R', 'LKB7156', 'RJ'),
('Iveco', 'Stralis Hi-Way', 'PQP6666', 'DF'),
('Mercedes', 'New Actross', 'KBO4620', 'GO');
SELECT * FROM veiculos;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA SERVICOS --
SELECT * FROM servicos;
INSERT INTO servicos (descricao, preco) VALUES
('Entrega Normal', 10.00),
('Entrega Expressa', 30.00),
('Express 10h', 10.00);
SELECT * FROM servicos;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA JURIDICA --
SELECT * FROM juridica;
INSERT INTO juridica (razao_social, cnpj, ie, im, clientes_id) VALUES
('Rita e Aurora Construções Ltda', '81970639000100', '0166036414114', '192538574910375', 1),
('Elza e Yuri Telecom ME', '69579777000159', '057312697007', '193640364718273', 2),
('Julia e Sebastiana Corretores Associados ME', '68652724000153', '06590950', '183640182750191', 3),
('Silvana e Yago Informática Ltda', '28051533000111', '0786217100122', '0786217100122', 4),
('Bianca e Jennifer Comercio de Bebidas ME', '97853232000124', '107114526', '127939826408387', 5);
SELECT * FROM juridica;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA FISICA --
SELECT * FROM fisica;
INSERT INTO fisica (nome, sobrenome, cpf, rg, clientes_id) VALUES
('Carlos Eduardo', 'Yago Samuel dos Santos', '84095861266', '391415281', '6'),
('Isabella Cristiane', 'da Conceição', '75756369511', '336218199', '7'),
('Nelson Calebe', 'Roberto Moreira', '86275706988', '320586194', '8'),
('Elisa Daiane', 'Drumond', '21475667302', '179956693', '9'),
('Caroline Milena', 'Antônia Brito', '35517636314', '257601739', '10');
SELECT * FROM fisica;
-- ######################################################## --

-- INSERINDO DADOS NA TABELA ORDENS_SERVICO --
SELECT * FROM ordens_servicos;
INSERT INTO ordens_servicos (servicos, cliente, origem, numero_origem, destino, numero_destino, objeto, quantidade, peso, preco_final, formas_pagamento, atendente, veiculo, data_recebimento) VALUES
(1, 1, 1, 87, 6, 352, 'Caixas com ligas de ferro', 4, 400.00, 570.89, 2, 1, 5, '2021-07-08'),
(3, 2, 3, 6567, 7, 874, 'Caixas de sapatos', 100, 100.00, 976.33, 1, 2, 1, '2021-12-27'),
(1, 3, 5, 74, 8, 786, 'Encomenda', 1, 0.800, 45.54, 3, 3, 2, '2021-10-07'),
(2, 4, 2, 'AE', 9, 216, 'Mesa de jantar', 1, 30.789, 350.12, 1, 1, 3, '2021-02-18'),
(2, 5, 2, 30, 10, 665, 'Mesa de jantar', 1, 30.789, 350.12, 1, 1, 4, '2021-01-06'),
(3, 6, 10, 55, 1, 321, 'Smartphone', 2, 0.500, 456.1, 1, 2, 3, '2021-10-27'),
(1, 7, 9, 10, 6, 11, 'Televisao', 1, 3.00, 678.12, 1, 2, 3, '2021-04-17'),
(2, 8, 8, 06, 8, 'S/N', 'Monitor', 1, 0.700, 120.55, 1, 2, 3, '2021-10-21');
SELECT * FROM ordens_servicos;
