---- MODELANDO E CRIANDO NOSSO DATA WAREHOUSE

create schema dw;

--- DIMENSOES

CREATE TABLE dw.dim_cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    email VARCHAR(100),
    sexo CHAR(1),
    data_nascimento DATE
);

CREATE TABLE dw.dim_regiao (
    id_regiao SERIAL PRIMARY KEY,
    nome_cidade VARCHAR(50),
	nome_estado VARCHAR(50),
	nome_pais VARCHAR(50)
);


CREATE TABLE dw.dim_produto (
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    categoria VARCHAR(50)
);


CREATE TABLE dw.dim_vendedor (
    id_vendedor SERIAL PRIMARY KEY,
    nome_vendedor VARCHAR(50),
    sobrenome_vendedor VARCHAR(50),
    data_contratacao DATE
);

--- DIM TEMPO

CREATE TABLE dw.dim_tempo (
    id_tempo SERIAL PRIMARY KEY,
    data DATE,
    ano INT,
    mes INT,
    dia INT,
    nome_dia_semana VARCHAR(20),
    nome_mes VARCHAR(20),
    trimestre INT,
    bimestre INT,
    semestre INT
);

INSERT INTO dw.dim_tempo (data, ano, mes, dia, nome_dia_semana, nome_mes, trimestre, bimestre, semestre)
SELECT 
    dt AS data,
    EXTRACT(YEAR FROM dt) AS ano,
    EXTRACT(MONTH FROM dt) AS mes,
    EXTRACT(DAY FROM dt) AS dia,
    TO_CHAR(dt, 'Day') AS nome_dia_semana,  -- Nome do dia da semana (Ex: Segunda, Terça)
    TO_CHAR(dt, 'Month') AS nome_mes,        -- Nome do mês (Ex: Janeiro, Fevereiro)
    EXTRACT(QUARTER FROM dt) AS trimestre,   -- Trimestre (1, 2, 3, 4)
    (EXTRACT(MONTH FROM dt) + 1) / 2 AS bimestre, -- Bimestre (1, 2, 3, 4, 5, 6)
    CASE 
        WHEN EXTRACT(MONTH FROM dt) <= 6 THEN 1
        ELSE 2
    END AS semestre                          -- Semestre (1 ou 2)
FROM
    generate_series('2015-01-01'::DATE, '2024-12-31'::DATE, '1 day'::INTERVAL) AS dt;

-- FATO VENDAS

CREATE TABLE dw.fato_vendas (
    id_venda SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES dw.dim_cliente(id_cliente),
    id_produto INT REFERENCES dw.dim_produto(id_produto),
    id_vendedor INT REFERENCES dw.dim_vendedor(id_vendedor),
    id_tempo INT REFERENCES dw.dim_tempo(id_tempo),
    id_regiao INT REFERENCES dw.dim_regiao(id_regiao),  
    quantidade INT,
    valor_venda NUMERIC(10,2)
);

	