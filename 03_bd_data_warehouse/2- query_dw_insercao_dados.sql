--- CARGA DE DADOS NO NOSSO DATAWAREHOUSE


--- dim_cliente

INSERT INTO dw.dim_cliente (nome, sobrenome, email, sexo, data_nascimento)
SELECT 
    nome, 
    sobrenome, 
    email, 
    sexo, 
    data_nascimento
FROM stage.clientes;

SELECT * FROM dw.dim_cliente;


--- dim_produto
INSERT INTO dw.dim_produto (nome_produto, categoria)
SELECT 
    nome_produto, 
    categoria
FROM stage.produtos;

SELECT * FROM dw.dim_produto;

--dim_vendedor
INSERT INTO dw.dim_vendedor (nome_vendedor, sobrenome_vendedor, data_contratacao)
SELECT 
    nome_vendedor, 
    sobrenome_vendedor, 
    data_contratacao
FROM stage.vendedores;

SELECT * FROM dw.dim_vendedor;

---dim_regiao

INSERT INTO dw.dim_regiao (nome_pais, nome_estado, nome_cidade)
SELECT 
    p.nome_pais,
    e.nome_estado,
    c.nome_cidade
FROM stage.estados e
JOIN stage.paises p ON e.id_pais = p.id_pais
JOIN stage.cidades c ON e.id_estado = c.id_estado;

SELECT * FROM dw.dim_regiao;

---fato_vendas

INSERT INTO dw.fato_vendas (id_cliente, id_produto, id_vendedor, id_tempo, id_regiao, quantidade, valor_venda)
SELECT
    c.id_cliente,                     -- Relacionando cliente (dim_cliente)
    p.id_produto,                     -- Relacionando produto (dim_produto)
    v.id_vendedor,                    -- Relacionando vendedor (dim_vendedor)
    t.id_tempo,                       -- Relacionando tempo (dim_tempo)
    r.id_regiao,                      -- Relacionando região (dim_regiao)
    s_vendas.quantidade,              -- Quantidade de produtos vendidos
    (s_vendas.quantidade * s_vendas.preco_unitario) AS valor_venda  -- Calculando o valor total da venda
FROM stage.vendas s_vendas
JOIN dw.dim_cliente c ON c.id_cliente = s_vendas.id_cliente         -- Relacionando cliente
JOIN dw.dim_produto p ON p.id_produto = s_vendas.id_produto         -- Relacionando produto
JOIN dw.dim_vendedor v ON v.id_vendedor = s_vendas.id_vendedor      -- Relacionando vendedor
JOIN dw.dim_tempo t ON t.data = s_vendas.data_venda                 -- Relacionando data
JOIN dw.dim_regiao r ON r.nome_cidade = (
    SELECT ci.nome_cidade 
    FROM stage.cidades ci
    WHERE ci.id_cidade = (SELECT v.id_cidade FROM stage.vendedores v WHERE v.id_vendedor = s_vendas.id_vendedor)  -- Relacionando cidade do vendedor
);

SELECT * FROM dw.fato_vendas LIMIT 10;


