--- COMO CRIAR UM BANCO DE STAGE (simulando que seja o schema STAGE)

--- 1- MODELAR AS TABELAS (CRIAR AS TABELAS)

--- CRIAR O SCHEMA

CREATE SCHEMA stage;

--- REFERENCIAR o schema nas minhas tabelas.

    -- Criação da tabela clientes
    CREATE TABLE stage.clientes (
        id_cliente SERIAL PRIMARY KEY,
        nome VARCHAR(50),
        sobrenome VARCHAR(50),
        email VARCHAR(100),
        sexo CHAR(1),
        data_nascimento DATE
    );

    -- Criação da tabela produtos
    CREATE TABLE stage.produtos (
        id_produto SERIAL PRIMARY KEY,
        nome_produto VARCHAR(100),
        categoria VARCHAR(50),
        preco NUMERIC(10,2) DEFAULT 0
    );

    -- Criação da tabela paises
    CREATE TABLE stage.paises (
        id_pais SERIAL PRIMARY KEY,
        nome_pais VARCHAR(50)
    );

    -- Criação da tabela estados
    CREATE TABLE stage.estados (
        id_estado SERIAL PRIMARY KEY,
        nome_estado VARCHAR(50),
        id_pais INT REFERENCES paises(id_pais)
    );

    -- Criação da tabela cidades
    CREATE TABLE stage.cidades (
        id_cidade SERIAL PRIMARY KEY,
        nome_cidade VARCHAR(50),
        id_estado INT REFERENCES estados(id_estado)
    );

    -- Criação da tabela vendedores
    CREATE TABLE stage.vendedores (
        id_vendedor SERIAL PRIMARY KEY,
        nome_vendedor VARCHAR(50),
        sobrenome_vendedor VARCHAR(50),
        cpf VARCHAR(11),
        id_cidade INT REFERENCES cidades(id_cidade),
        data_contratacao DATE
    );

    -- Criação da tabela regioes
    CREATE TABLE stage.regioes (
        id_regiao SERIAL PRIMARY KEY,
        nome_regiao VARCHAR(50)
    );

    -- Criação da tabela vendas com relacionamentos corrigidos
    CREATE TABLE stage.vendas (
        id_venda SERIAL PRIMARY KEY,
        data_venda DATE,
        id_cliente INT REFERENCES clientes(id_cliente),
        id_produto INT REFERENCES produtos(id_produto),
        id_vendedor INT REFERENCES vendedores(id_vendedor),
        id_regiao INT REFERENCES regioes(id_regiao),
        quantidade INT,
        preco_unitario NUMERIC(10,2)
    );
