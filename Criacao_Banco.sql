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

-- ------------------------- --
-- CRIACAO DO BANCO DE DADOS --
-- ------------------------- --
DROP DATABASE IF EXISTS transportadora;
CREATE DATABASE transportadora;									

-- ------------------- --
-- CRIACAO DAS TABELAS --
-- ------------------- --

-- CRIAÇÃO DA TABELA ENDERECOS _______________________________________________________________________________________________--
DROP TABLE IF EXISTS enderecos; -- OK
CREATE TABLE IF NOT EXISTS enderecos (
	id SERIAL NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep INT NOT NULL CHECK(cep > 9999999)  CHECK(cep < 100000000),
  PRIMARY KEY (id)
);

-- CRIAÇÃO DA TABELA TELEFONES _______________________________________________________________________________________________--
DROP TABLE IF EXISTS telefones; -- OK
CREATE TABLE IF NOT EXISTS telefones (
	id SERIAL NOT NULL,
	 ddd INT NOT NULL CHECK(ddd > 0)  CHECK(ddd < 100),
	 telefone INTEGER NOT NULL CHECK (telefone > 9999999) CHECK (telefone < 1000000000),
  PRIMARY KEY (id) 
);

-- CRIAÇÃO DA TABELA CLIENTES ________________________________________________________________________________________________--
DROP TABLE IF EXISTS clientes; -- OK
CREATE TABLE IF NOT EXISTS clientes (
	id SERIAL NOT NULL,
    endereco INTEGER NOT NULL,
    numero VARCHAR(10) NOT NULL DEFAULT '',
    telefone SERIAL NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_clientes_enderecos
		FOREIGN KEY (endereco)
		REFERENCES enderecos (id),
  CONSTRAINT fk_clientes_telefones
		FOREIGN KEY (telefone)
    REFERENCES telefones (id)
);

-- CRIAÇÃO DA TABELA FISICA __________________________________________________________________________________________________--
DROP TABLE IF EXISTS fisica; -- OK
CREATE TABLE IF NOT EXISTS fisica (
	nome VARCHAR(50) NOT NULL,
	sobrenome VARCHAR(50) NOT NULL,
	cpf CHAR(11) NOT NULL,
	rg VARCHAR(15) NOT NULL,
	clientes_id SERIAL NOT NULL,
	PRIMARY KEY (clientes_id),
	CONSTRAINT fk_fisica_clientes
		FOREIGN KEY (clientes_id)
		REFERENCES clientes (id)
);

-- CRIAÇÃO DA TABELA JURIDICA ________________________________________________________________________________________________--
DROP TABLE IF EXISTS juridica; -- OK
CREATE TABLE IF NOT EXISTS juridica (
	razao_social VARCHAR(50) NOT NULL,
	cnpj CHAR(14) NOT NULL,
	ie VARCHAR(15) NULL DEFAULT '',
	im VARCHAR(15) NULL DEFAULT '',
	clientes_id SERIAL NOT NULL,
	PRIMARY KEY (clientes_id),
	CONSTRAINT fk_juridica_clientes
		FOREIGN KEY (clientes_id)
		REFERENCES clientes (id)
);

-- CRIAÇÃO DA TABELA CARGOS __________________________________________________________________________________________________--
DROP TABLE IF EXISTS cargos; -- OK
CREATE TABLE IF NOT EXISTS cargos (
	id SERIAL NOT NULL,
	descricao VARCHAR(50) NOT NULL,
	PRIMARY KEY (id)
);

-- CRIAÇÃO DA TABELA FUNCIONÁRIOS ____________________________________________________________________________________________--
DROP TABLE IF EXISTS funcionarios; -- OK
CREATE TABLE IF NOT EXISTS funcionarios (
	id SERIAL NOT NULL,
	matricula INT NOT NULL,
	nome VARCHAR(100) NOT NULL,
	cargo INT NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT fk_funcionarios_cargos
		FOREIGN KEY (cargo)
		REFERENCES cargos (id)
);

-- CRIAÇÃO DA TABELA FORMAS_PAGAMENTO ________________________________________________________________________________________--
DROP TABLE IF EXISTS formas_pagamento; -- OK
CREATE TABLE IF NOT EXISTS formas_pagamento (
	id SERIAL NOT NULL,
	descricao VARCHAR(50) NOT NULL,
	taxas FLOAT NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
);

-- CRIAÇÃO DA TABELA SERVICOS ________________________________________________________________________________________________--
DROP TABLE IF EXISTS servicos; -- OK
CREATE TABLE IF NOT EXISTS servicos (
	id SERIAL NOT NULL,
	descricao VARCHAR(50) NOT NULL,
	preco FLOAT NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
);

-- CRIAÇÃO DA TABELA VEICULOS ________________________________________________________________________________________________--
DROP TABLE IF EXISTS veiculos; -- OK
CREATE TABLE IF NOT EXISTS veiculos (
	id SERIAL NOT NULL,
	marca VARCHAR(30) NOT NULL,
	modelo VARCHAR(30) NOT NULL,
	placa CHAR(7) NOT NULL,
	estado CHAR(2) NOT NULL,
	PRIMARY KEY (id)
);

-- CRIAÇÃO DA TABELA ORDENS_SERVICOS _________________________________________________________________________________________--
DROP TABLE IF EXISTS ordens_servicos; -- OK
CREATE TABLE IF NOT EXISTS ordens_servicos (
	id SERIAL NOT NULL,
	servicos SERIAL NOT NULL,
	cliente SERIAL NOT NULL,
	origem SERIAL NOT NULL,
	numero_origem VARCHAR(10) NOT NULL DEFAULT '',
	destino SERIAL NOT NULL,
	numero_destino VARCHAR(10) NOT NULL DEFAULT '',
	objeto VARCHAR(200) NOT NULL,
	quantidade INTEGER NOT NULL DEFAULT 0,
	peso FLOAT NOT NULL DEFAULT 0,
	preco_final FLOAT NOT NULL DEFAULT 0,
	formas_pagamento SERIAL NOT NULL,
	atendente SERIAL NOT NULL,
	veiculo SERIAL NOT NULL,
	data_recebimento DATE NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT fk_ordens_servicos_veiculos
		FOREIGN KEY (veiculo)
		REFERENCES veiculos (id),
	CONSTRAINT fk_ordens_servicos_funcionarios
		FOREIGN KEY (atendente)
		REFERENCES funcionarios (id),
	CONSTRAINT fk_ordens_servicos_servicos
		FOREIGN KEY (servicos)
		REFERENCES servicos (id),
	CONSTRAINT fk_ordens_servicos_formas_pagamento
		FOREIGN KEY (formas_pagamento)
		REFERENCES formas_pagamento (id),
	CONSTRAINT fk_ordens_servicos_enderecos_origem
		FOREIGN KEY (origem)
		REFERENCES enderecos (id),
	CONSTRAINT fk_ordens_servicos_clientes
		FOREIGN KEY (cliente)
		REFERENCES clientes (id),
	CONSTRAINT fk_ordens_servicos_enderecos_destino
		FOREIGN KEY (destino)
		REFERENCES enderecos (id)
);