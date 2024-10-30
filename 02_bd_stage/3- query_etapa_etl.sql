--- ETAPA DE ETL ---

--- 1 - IDENTIFICAR NAS TABELAS DO NOSSO BANCO DE DADOS RELACIONAL, SE ELAS TEM VALORES NULOS.

-- Verificar valores nulos na tabela clientes - nao tem nulo mais esta como NONE

---CLIENTES

SELECT * FROM clientes;

SELECT 'clientes' AS tabela, 
COUNT(*) AS total_nulos
FROM clientes
WHERE nome IS NULL OR sobrenome IS NULL OR email IS NULL OR sexo IS NULL OR data_nascimento IS NULL;

--- CIDADES

SELECT * FROM cidades;


--- 2 - IDENTIFICAR NAS TABELAS OS REGISTROS DUPLICADOS.

--- Verificar valores duplicados na tabela clientes.

---CLIENTES
select * from clientes;

SELECT nome, sobrenome, email, sexo, data_nascimento, COUNT(*)
FROM clientes
GROUP BY nome, sobrenome, email, sexo, data_nascimento
HAVING COUNT(*) > 1;

--- 3 - VERIFICAR OS VALORES INCONSISTENTES.

-- Verificar valores negativos ou zerados na tabela produtos - aqui tem.
select * from produtos;

SELECT 'produtos' AS tabela, COUNT(*) AS total_inconsistentes
FROM produtos
WHERE preco <= 0;

SELECT nome_produto, categoria, preco
FROM produtos
WHERE preco <= 0;

SELECT * FROM produtos;