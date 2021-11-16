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

USE transportadora;

-- PESQUISA DOS FUNCIONARIOS CADASTRADOS
SELECT
	funcionarios.id,
    funcionarios.matricula,
    funcionarios.nome,
    cargos.descricao
FROM funcionarios
LEFT JOIN cargos ON cargos.id = funcionarios.id;
-- ######################################################## --

-- PESQUISA DE TODOS OS ENDERECOS CADASTRADOS
SELECT * FROM enderecos;
-- ######################################################## --

-- PESQUISA DOS CLIENTES PESSOA JURIDICA CADASTRADOS
SELECT 
	clientes.id,
    juridica.razao_social AS razao_social,
    juridica.cnpj AS cnpj,
    juridica.ie AS inscricao_estadual,
    juridica.im AS inscricao_municipal,
    CONCAT (enderecos.logradouro, ' ', clientes.numero) AS endereco,
    enderecos.bairro AS bairro,
    enderecos.cidade AS cidade,
    enderecos.uf AS uf,
    enderecos.cep AS cep,
    CONCAT ( '(',telefones.ddd, ') ', telefones.telefone) AS numero
FROM clientes
LEFT JOIN fisica ON clientes.id = fisica.clientes_id
LEFT JOIN juridica ON clientes.id = juridica.clientes_id
LEFT JOIN enderecos ON clientes.endereco = enderecos.id
LEFT JOIN telefones ON clientes.telefone = telefones.id
WHERE CASE WHEN fisica.nome IS NULL THEN 'juridica' ELSE 'fisica' END = 'juridica';
-- ######################################################## --

-- PESQUISA DOS CLIENTES PESSOA FISICA CADASTRADOS
SELECT 
	clientes.id,
    CONCAT(fisica.nome, ' ', fisica.sobrenome) AS nome,
    fisica.cpf AS cpf,
    fisica.rg AS rg,
    CONCAT (enderecos.logradouro, ' ', clientes.numero) AS endereco,
    enderecos.bairro AS bairro,
    enderecos.cidade AS cidade,
    enderecos.uf AS uf,
    enderecos.cep AS cep,
    CONCAT ( '(',telefones.ddd, ') ', telefones.telefone) AS numero
FROM clientes
LEFT JOIN fisica ON clientes.id = fisica.clientes_id
LEFT JOIN enderecos ON clientes.endereco = enderecos.id
LEFT JOIN telefones ON clientes.telefone = telefones.id
WHERE CASE WHEN fisica.nome IS NULL THEN 'juridica' ELSE 'fisica' END = 'fisica';
-- ######################################################## --

-- PESQUISA TODOS CLIENTES CADASTRADOS
SELECT 
	clientes.id,
	CASE WHEN fisica.nome IS NULL THEN 'juridica' ELSE 'fisica' END AS tipo,
    COALESCE(CONCAT(fisica.nome, fisica.sobrenome), juridica.razao_social) AS nome,
    CONCAT (enderecos.logradouro, ' ', clientes.numero) AS endereco,
    enderecos.bairro AS bairro,
    enderecos.cidade AS cidade,
    enderecos.uf AS uf,
    enderecos.cep AS cep,
    CONCAT ( '(',telefones.ddd, ') ', telefones.telefone) AS numero
FROM clientes
LEFT JOIN fisica ON clientes.id = fisica.clientes_id
LEFT JOIN juridica ON clientes.id = juridica.clientes_id
LEFT JOIN enderecos ON clientes.endereco = enderecos.id
LEFT JOIN telefones ON clientes.telefone = telefones.id;
-- ######################################################## --

-- PESQUISA SOMENTE OS PEDIDOS DA PESSOA JURIDICA
SELECT ordens.id, 
    juridica.razao_social AS razao_social,
    juridica.cnpj AS cnpj,
    ordens.objeto, 
    ordens.quantidade,
    ordens.peso,
    ordens.preco_final
FROM ordens_servicos ordens
INNER JOIN clientes ON ordens.cliente = clientes.id
INNER JOIN juridica ON clientes.id = juridica.clientes_id;
-- ######################################################## --

-- PESQUISA SOMENTE OS PEDIDOS DA PESSOA FISICA
SELECT ordens.id, 
    fisica.nome AS nome,
    ordens.objeto, 
    ordens.quantidade,
    ordens.peso,
    ordens.preco_final
FROM ordens_servicos ordens
INNER JOIN clientes ON ordens.cliente = clientes.id
INNER JOIN fisica ON clientes.id = fisica.clientes_id;
-- ######################################################## --

-- PESQUISA COMPLETA DA TABELA ORDENS_SERVICOS
SELECT ordens.id, 
    CASE WHEN fisica.nome IS NULL THEN 'juridica' ELSE 'fisica' END AS tipo,
	COALESCE(fisica.nome, juridica.razao_social) AS cliente_nome,
    servicos.descricao AS descricao_servico,
    CONCAT(endereco_origem.logradouro, ' - ', ordens.numero_origem, ', ', endereco_origem.bairro, ', ', endereco_origem.cidade, ' - ', endereco_origem.uf) AS endereco_origem,
    endereco_origem.cep AS cep_origem,
    CONCAT(endereco_destino.logradouro, ' - ', ordens.numero_destino, ', ', endereco_destino.bairro, ', ', endereco_destino.cidade, ' - ', endereco_destino.uf) AS endereco_destino,
    endereco_destino.cep AS cep_destino,
    funcionario.nome AS funcionario_nome,
    ordens.objeto, 
    ordens.quantidade,
    ordens.peso,
    ordens.preco_final AS preco,
    FORMAT(ordens.preco_final * (pagamento.taxas/100), 2) AS taxas,
    FORMAT (ordens.preco_final + FORMAT(ordens.preco_final * (pagamento.taxas/100), 2), 2) AS preco_final,
    pagamento.descricao,
    CONCAT (veiculo.marca, ' - ', veiculo.modelo, ' (', veiculo.placa, ' - ', veiculo.estado, ')') AS veiculo,
    ordens.data_recebimento AS data_recebido
FROM ordens_servicos ordens
INNER JOIN servicos ON ordens.servicos = servicos.id 
INNER JOIN clientes ON ordens.cliente = clientes.id
LEFT JOIN fisica ON clientes.id = fisica.clientes_id
LEFT JOIN juridica ON clientes.id = juridica.clientes_id
INNER JOIN enderecos endereco_origem ON ordens.origem = endereco_origem.id
INNER JOIN enderecos endereco_destino ON ordens.destino = endereco_destino.id
INNER JOIN formas_pagamento pagamento ON ordens.formas_pagamento = pagamento.id
INNER JOIN funcionarios funcionario ON ordens.atendente = funcionario.id
INNER JOIN veiculos veiculo ON ordens.veiculo = veiculo.id;
-- ######################################################## --

-- SELECIONAR AS ORDENS DE SERVICO COM DESTINO PARA O ACRE
SELECT ordens.id, 
    CASE WHEN fisica.nome IS NULL THEN 'juridica' ELSE 'fisica' END AS tipo,
	COALESCE(fisica.nome, juridica.razao_social) AS cliente_nome,
    servicos.descricao AS descricao_servico,
    CONCAT(endereco_origem.logradouro, ' - ', ordens.numero_origem, ', ', endereco_origem.bairro, ', ', endereco_origem.cidade, ' - ', endereco_origem.uf) AS endereco_origem,
    endereco_origem.cep AS cep_origem,
    CONCAT(endereco_destino.logradouro, ' - ', ordens.numero_destino, ', ', endereco_destino.bairro, ', ', endereco_destino.cidade, ' - ', endereco_destino.uf) AS endereco_destino,
    endereco_destino.cep AS cep_destino,
    funcionario.nome AS funcionario_nome,
    ordens.objeto, 
    ordens.quantidade,
    ordens.peso,
    ordens.preco_final,
    pagamento.descricao,
    CONCAT (veiculo.marca, ' - ', veiculo.modelo, ' (', veiculo.placa, ' - ', veiculo.estado, ')') AS veiculo,
    ordens.data_recebimento AS data_recebido
FROM ordens_servicos ordens
INNER JOIN servicos ON ordens.servicos = servicos.id 
INNER JOIN clientes ON ordens.cliente = clientes.id
LEFT JOIN fisica ON clientes.id = fisica.clientes_id
LEFT JOIN juridica ON clientes.id = juridica.clientes_id
INNER JOIN enderecos endereco_origem ON ordens.origem = endereco_origem.id
INNER JOIN enderecos endereco_destino ON ordens.destino = endereco_destino.id
INNER JOIN formas_pagamento pagamento ON ordens.formas_pagamento = pagamento.id
INNER JOIN funcionarios funcionario ON ordens.atendente = funcionario.id
INNER JOIN veiculos veiculo ON ordens.veiculo = veiculo.id
WHERE endereco_destino.uf = 'AC';
-- ######################################################## --

-- SELECIONAR AS ORDENS DE SERVICO QUE A Noémi
SELECT ordens.id, 
    CASE WHEN fisica.nome IS NULL THEN 'juridica' ELSE 'fisica' END AS tipo,
	COALESCE(fisica.nome, juridica.razao_social) AS cliente_nome,
    servicos.descricao AS descricao_servico,
    CONCAT(endereco_origem.logradouro, ' - ', ordens.numero_origem, ', ', endereco_origem.bairro, ', ', endereco_origem.cidade, ' - ', endereco_origem.uf) AS endereco_origem,
    endereco_origem.cep AS cep_origem,
    CONCAT(endereco_destino.logradouro, ' - ', ordens.numero_destino, ', ', endereco_destino.bairro, ', ', endereco_destino.cidade, ' - ', endereco_destino.uf) AS endereco_destino,
    endereco_destino.cep AS cep_destino,
    funcionario.nome AS funcionario_nome,
    ordens.objeto, 
    ordens.quantidade,
    ordens.peso,
    ordens.preco_final,
    pagamento.descricao,
    CONCAT (veiculo.marca, ' - ', veiculo.modelo, ' (', veiculo.placa, ' - ', veiculo.estado, ')') AS veiculo,
    ordens.data_recebimento AS data_recebido
FROM ordens_servicos ordens
INNER JOIN servicos ON ordens.servicos = servicos.id 
INNER JOIN clientes ON ordens.cliente = clientes.id
LEFT JOIN fisica ON clientes.id = fisica.clientes_id
LEFT JOIN juridica ON clientes.id = juridica.clientes_id
INNER JOIN enderecos endereco_origem ON ordens.origem = endereco_origem.id
INNER JOIN enderecos endereco_destino ON ordens.destino = endereco_destino.id
INNER JOIN formas_pagamento pagamento ON ordens.formas_pagamento = pagamento.id
INNER JOIN funcionarios funcionario ON ordens.atendente = funcionario.id
INNER JOIN veiculos veiculo ON ordens.veiculo = veiculo.id
WHERE funcionario.nome = 'Noémi Castelo Branco Doutis';
-- ######################################################## --

-- SELECIONAR AS ORDENS DE SERVICO QUE A FORAM RECEBIDOS NO DIA 27
SELECT ordens.id, 
    CASE WHEN fisica.nome IS NULL THEN 'juridica' ELSE 'fisica' END AS tipo,
	COALESCE(fisica.nome, juridica.razao_social) AS cliente_nome,
    servicos.descricao AS descricao_servico,
    CONCAT(endereco_origem.logradouro, ' - ', ordens.numero_origem, ', ', endereco_origem.bairro, ', ', endereco_origem.cidade, ' - ', endereco_origem.uf) AS endereco_origem,
    endereco_origem.cep AS cep_origem,
    CONCAT(endereco_destino.logradouro, ' - ', ordens.numero_destino, ', ', endereco_destino.bairro, ', ', endereco_destino.cidade, ' - ', endereco_destino.uf) AS endereco_destino,
    endereco_destino.cep AS cep_destino,
    funcionario.nome AS funcionario_nome,
    ordens.objeto, 
    ordens.quantidade,
    ordens.peso,
    ordens.preco_final,
    pagamento.descricao,
    CONCAT (veiculo.marca, ' - ', veiculo.modelo, ' (', veiculo.placa, ' - ', veiculo.estado, ')') AS veiculo,
    ordens.data_recebimento AS data_recebido
FROM ordens_servicos ordens
INNER JOIN servicos ON ordens.servicos = servicos.id 
INNER JOIN clientes ON ordens.cliente = clientes.id
LEFT JOIN fisica ON clientes.id = fisica.clientes_id
LEFT JOIN juridica ON clientes.id = juridica.clientes_id
INNER JOIN enderecos endereco_origem ON ordens.origem = endereco_origem.id
INNER JOIN enderecos endereco_destino ON ordens.destino = endereco_destino.id
INNER JOIN formas_pagamento pagamento ON ordens.formas_pagamento = pagamento.id
INNER JOIN funcionarios funcionario ON ordens.atendente = funcionario.id
INNER JOIN veiculos veiculo ON ordens.veiculo = veiculo.id
WHERE DAY(ordens.data_recebimento) = "27";
-- ######################################################## --

-- SELECIONAR AS ORDENS DE SERVICO QUE A FORAM RECEBIDOS NO ANO DE 2021
SELECT ordens.id, 
    CASE WHEN fisica.nome IS NULL THEN 'juridica' ELSE 'fisica' END AS tipo,
	COALESCE(fisica.nome, juridica.razao_social) AS cliente_nome,
    servicos.descricao AS descricao_servico,
    CONCAT(endereco_origem.logradouro, ' - ', ordens.numero_origem, ', ', endereco_origem.bairro, ', ', endereco_origem.cidade, ' - ', endereco_origem.uf) AS endereco_origem,
    endereco_origem.cep AS cep_origem,
    CONCAT(endereco_destino.logradouro, ' - ', ordens.numero_destino, ', ', endereco_destino.bairro, ', ', endereco_destino.cidade, ' - ', endereco_destino.uf) AS endereco_destino,
    endereco_destino.cep AS cep_destino,
    funcionario.nome AS funcionario_nome,
    ordens.objeto, 
    ordens.quantidade,
    ordens.peso,
    ordens.preco_final,
    pagamento.descricao,
    CONCAT (veiculo.marca, ' - ', veiculo.modelo, ' (', veiculo.placa, ' - ', veiculo.estado, ')') AS veiculo,
    ordens.data_recebimento AS data_recebido
FROM ordens_servicos ordens
INNER JOIN servicos ON ordens.servicos = servicos.id 
INNER JOIN clientes ON ordens.cliente = clientes.id
LEFT JOIN fisica ON clientes.id = fisica.clientes_id
LEFT JOIN juridica ON clientes.id = juridica.clientes_id
INNER JOIN enderecos endereco_origem ON ordens.origem = endereco_origem.id
INNER JOIN enderecos endereco_destino ON ordens.destino = endereco_destino.id
INNER JOIN formas_pagamento pagamento ON ordens.formas_pagamento = pagamento.id
INNER JOIN funcionarios funcionario ON ordens.atendente = funcionario.id
INNER JOIN veiculos veiculo ON ordens.veiculo = veiculo.id
WHERE YEAR(ordens.data_recebimento) = "2021";
-- ######################################################## --