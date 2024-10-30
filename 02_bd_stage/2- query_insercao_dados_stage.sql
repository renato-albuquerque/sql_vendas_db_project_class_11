--- 2. CARREGAR (CARGA, CÓPIA) dos dados das minhas tabelas no BANCO RELACIONAL (schema public) para
--- as minhas tabelas no banco de STAGE (schema STAGE)

--- tabela clientes
select * from public.clientes;

TRUNCATE stage.clientes;
	
INSERT INTO stage.clientes (nome, sobrenome, email, sexo, data_nascimento)
SELECT nome, sobrenome, email, sexo, data_nascimento
FROM public.clientes;

-- Verificar se os dados foram inseridos corretamente
SELECT * FROM stage.clientes;

--- tabela produtos
select * from public.produtos;

TRUNCATE stage.produtos;

INSERT INTO stage.produtos (nome_produto, categoria, preco)
SELECT nome_produto, categoria, preco
FROM public.produtos;

-- Verificar se os dados foram inseridos corretamente
SELECT * FROM stage.produtos;

--- tabela de paises
select * from public.paises;

TRUNCATE stage.paises;

INSERT INTO stage.paises (nome_pais)
SELECT nome_pais
FROM public.paises;

-- Verificar se os dados foram inseridos corretamente
SELECT * FROM stage.paises;

---tabela estados
select * from public.estados;

TRUNCATE stage.estados;

INSERT INTO stage.estados (nome_estado, id_pais)
SELECT nome_estado, id_pais
FROM public.estados;

-- Verificar se os dados foram inseridos corretamente
SELECT * FROM stage.estados;

---tabela cidades
select * from public.cidades;

TRUNCATE stage.cidades;

INSERT INTO stage.cidades (nome_cidade, id_estado)
SELECT nome_cidade, id_estado
FROM public.cidades;

-- Verificar se os dados foram inseridos corretamente
SELECT * FROM stage.cidades;

---tabela vendedores
select * from public.vendedores;

TRUNCATE stage.vendedores;

INSERT INTO stage.vendedores (nome_vendedor, sobrenome_vendedor, cpf, id_cidade, data_contratacao)
SELECT nome_vendedor, sobrenome_vendedor, cpf, id_cidade, data_contratacao
FROM public.vendedores;

-- Verificar se os dados foram inseridos corretamente
SELECT * FROM stage.vendedores;

---tabela regioes
select * from public.regioes;

TRUNCATE stage.regioes;

INSERT INTO stage.regioes (nome_regiao)
SELECT nome_regiao
FROM public.regioes;

-- Verificar se os dados foram inseridos corretamente
SELECT * FROM stage.regioes;

--- tabela vendas
select * from public.vendas;

TRUNCATE stage.vendas;

INSERT INTO stage.vendas (data_venda, id_cliente, id_produto, id_vendedor, id_regiao, quantidade, preco_unitario)
SELECT data_venda, id_cliente, id_produto, id_vendedor, id_regiao, quantidade, preco_unitario
FROM public.vendas;

-- Verificar se os dados foram inseridos corretamente
SELECT * FROM stage.vendas;
