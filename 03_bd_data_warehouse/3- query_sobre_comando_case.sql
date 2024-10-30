--- SOBRE O COMANDO CASE

--- VENDAS POR CATEGORIA (alta, média e baixa)

SELECT 
    f.id_venda,
    f.valor_venda,
    CASE 
        WHEN f.valor_venda > 2000 THEN 'Alta'
        WHEN f.valor_venda BETWEEN 1000 AND 2000 THEN 'Média'
        ELSE 'Baixa'
    END AS categoria_venda
FROM dw.fato_vendas f;


---- FILTRANDO UMA CATEGORIA DE VENDA USANDO CASE E SUBQUERY

SELECT *
FROM (
	SELECT
		id_venda,
		valor_venda,
		CASE
		WHEN valor_venda > 2000 THEN 'Alta'
		WHEN valor_venda BETWEEN 1000 AND 2000 THEN 'Media'
		ELSE 'Baixa'
		END AS categoria_venda
	FROM dw.fato_vendas) as vendas_categorias
WHERE categoria_venda = 'Baixa';

--- APLICACAO CASE PARA O DESCONTO

SELECT 
    f.id_venda,
    f.valor_venda,
    CASE 
        WHEN f.valor_venda > 1000 THEN (f.valor_venda * 0.10)::numeric(10,2)
        WHEN f.valor_venda BETWEEN 500 AND 1000 THEN (f.valor_venda * 0.05)::numeric(10,2)
        ELSE 0
    END AS desconto_aplicado
FROM dw.fato_vendas f;

--- SUM COM CASE - CONTAGEM CONDICIONAL

SELECT 
    SUM(CASE WHEN f.valor_venda > 2000 THEN 1 ELSE 0 END) AS vendas_altas,
    SUM(CASE WHEN f.valor_venda BETWEEN 1000 AND 2000 THEN 1 ELSE 0 END) AS vendas_medias,
    SUM(CASE WHEN f.valor_venda < 1000 THEN 1 ELSE 0 END) AS vendas_baixas
FROM dw.fato_vendas f;


----Alteração na Tabela Fato para Incluir a Coluna de Desconto Usando CASE

--- ALTER (altera a estrutura da tabela)
ALTER TABLE dw.fato_vendas
ADD COLUMN desconto_aplicado NUMERIC(5,2);


--- UPDATE (altera os valores contidos naquela tabela)
UPDATE dw.fato_vendas
SET desconto_aplicado = 
    CASE 
        WHEN valor_venda > 1000 THEN 0.10
        WHEN valor_venda BETWEEN 500 AND 1000 THEN 0.05
        ELSE 0
    END;


--- consultando após inclusão dos valores

SELECT 
    id_venda,
    valor_venda,
    desconto_aplicado,
    (valor_venda - (valor_venda * desconto_aplicado)) AS valor_final_com_desconto
FROM dw.fato_vendas;

