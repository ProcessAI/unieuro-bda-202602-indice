-- Atividade de BDA: executar em um banco VAZIO chamado bda_indices.
-- ATENÇÃO: apaga as tabelas desta atividade, caso existam.
DROP TABLE IF EXISTS venda CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;

CREATE TABLE cliente (
    id_cliente integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente_nome varchar(100) NOT NULL,
    cliente_cidade varchar(60) NOT NULL
);

CREATE TABLE produto (
    id_produto integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    produto_descricao varchar(100) NOT NULL,
    produto_categoria varchar(30) NOT NULL
);

CREATE TABLE venda (
    id_venda bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente integer NOT NULL REFERENCES cliente(id_cliente),
    id_produto integer NOT NULL REFERENCES produto(id_produto),
    venda_data date NOT NULL,
    venda_status varchar(15) NOT NULL,
    venda_valor numeric(10,2) NOT NULL
);

INSERT INTO cliente (cliente_nome, cliente_cidade)
SELECT 'Cliente ' || n, (ARRAY['Brasília','Goiânia','São Paulo','Salvador','Recife'])[1+(n%5)]
FROM generate_series(1, 20000) AS n;

INSERT INTO produto (produto_descricao, produto_categoria)
SELECT 'Produto ' || n, (ARRAY['Informática','Casa','Livros','Esporte'])[1+(n%4)]
FROM generate_series(1, 500) AS n;

SELECT (SELECT count(*) FROM cliente) AS clientes,
       (SELECT count(*) FROM produto) AS produtos,
       (SELECT count(*) FROM venda) AS vendas;
