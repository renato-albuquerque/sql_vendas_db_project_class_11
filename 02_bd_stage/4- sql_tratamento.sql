-- Verificar valores nulos na tabela clientes - nao tem nulo mais esta como NONE
SELECT 'clientes' AS tabela, COUNT(*) AS total_nulos
FROM clientes
WHERE nome IS NULL OR sobrenome IS NULL OR email IS NULL OR sexo IS NULL OR data_nascimento IS NULL;

SELECT * FROM clientes;

-- Verificar duplicatas na tabela clientes
SELECT 'clientes' AS tabela, COUNT(*) AS total_duplicatas
FROM clientes
GROUP BY nome, sobrenome, email, sexo, data_nascimento
HAVING COUNT(*) > 1;

-- Verificar valores nulos na tabela produtos - esta como none
SELECT 'produtos' AS tabela, COUNT(*) AS total_nulos
FROM produtos
WHERE nome_produto IS NULL OR categoria IS NULL OR preco IS NULL;

SELECT * FROM produtos;

-- Verificar valores negativos ou zerados na tabela produtos - aqui tem.
SELECT 'produtos' AS tabela, COUNT(*) AS total_inconsistentes
FROM produtos
WHERE preco <= 0;

-- Verificar duplicatas na tabela produtos
SELECT 'produtos' AS tabela, COUNT(*) AS total_duplicatas
FROM produtos
GROUP BY nome_produto, categoria
HAVING COUNT(*) > 1;

-- Verificar valores nulos na tabela vendas
SELECT 'vendas' AS tabela, COUNT(*) AS total_nulos
FROM vendas
WHERE id_cliente IS NULL OR id_produto IS NULL OR id_vendedor IS NULL OR quantidade IS NULL OR preco_unitario IS NULL;

-- Verificar duplicatas na tabela vendas
SELECT 'vendas' AS tabela, COUNT(*) AS total_duplicatas
FROM vendas
GROUP BY id_cliente, id_produto, id_vendedor, id_regiao, data_venda, quantidade, preco_unitario
HAVING COUNT(*) > 1;

-- Verificar valores negativos ou zerados na tabela vendas
SELECT 'vendas' AS tabela, COUNT(*) AS total_inconsistentes
FROM vendas
WHERE quantidade <= 0 OR preco_unitario <= 0;

-- Verificar valores nulos na tabela vendedores
SELECT 'vendedores' AS tabela, COUNT(*) AS total_nulos
FROM vendedores
WHERE nome_vendedor IS NULL OR sobrenome_vendedor IS NULL OR cpf IS NULL OR id_cidade IS NULL OR data_contratacao IS NULL;

SELECT * FROM vendedores;

-- Verificar duplicatas de CPF na tabela vendedores
SELECT 'vendedores' AS tabela, COUNT(*) AS total_duplicatas
FROM vendedores
GROUP BY cpf
HAVING COUNT(*) > 1;

-- Verificar CPFs inválidos na tabela vendedores (menores que 11 dígitos)
SELECT 'vendedores' AS tabela, COUNT(*) AS total_inconsistentes
FROM vendedores
WHERE LENGTH(cpf) < 11;

-- Verificar valores nulos na tabela regioes
SELECT 'regioes' AS tabela, COUNT(*) AS total_nulos
FROM regioes
WHERE nome_regiao IS NULL;

SELECT * FROM regioes;

-- Verificar duplicatas na tabela regioes
SELECT 'regioes' AS tabela, COUNT(*) AS total_duplicatas
FROM regioes
GROUP BY nome_regiao
HAVING COUNT(*) > 1;

-- Verificar valores nulos na tabela cidades
SELECT 'cidades' AS tabela, COUNT(*) AS total_nulos
FROM cidades
WHERE nome_cidade IS NULL OR id_estado IS NULL;

SELECT * FROM cidades;

-- Verificar duplicatas na tabela cidades
SELECT 'cidades' AS tabela, COUNT(*) AS total_duplicatas
FROM cidades
GROUP BY nome_cidade, id_estado
HAVING COUNT(*) > 1;

-- Verificar valores nulos na tabela estados
SELECT 'estados' AS tabela, COUNT(*) AS total_nulos
FROM estados
WHERE nome_estado IS NULL OR id_pais IS NULL;

-- Verificar duplicatas na tabela estados
SELECT 'estados' AS tabela, COUNT(*) AS total_duplicatas
FROM estados
GROUP BY nome_estado, id_pais
HAVING COUNT(*) > 1;

SELECT * FROM estados;

-- Verificar valores nulos na tabela paises
SELECT 'paises' AS tabela, COUNT(*) AS total_nulos
FROM paises
WHERE nome_pais IS NULL;

-- Verificar duplicatas na tabela paises
SELECT 'paises' AS tabela, COUNT(*) AS total_duplicatas
FROM paises
GROUP BY nome_pais
HAVING COUNT(*) > 1;

SELECT * FROM paises;