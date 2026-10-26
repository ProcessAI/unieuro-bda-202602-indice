-- Confira o total esperado de vendas: 1.200.000
SELECT count(*) AS total_vendas FROM venda;

-- Confira a presença dos índices (PK também aparece aqui).
SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'public' AND tablename = 'venda'
ORDER BY indexname;

-- Tamanho da tabela, índices e total
SELECT pg_size_pretty(pg_relation_size('venda')) AS tamanho_tabela,
       pg_size_pretty(pg_indexes_size('venda')) AS tamanho_indices,
       pg_size_pretty(pg_total_relation_size('venda')) AS tamanho_total;
