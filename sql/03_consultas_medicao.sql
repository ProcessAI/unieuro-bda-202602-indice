-- Execute cada EXPLAIN ANALYZE 3 vezes ANTES e 3 vezes DEPOIS dos índices.
-- Anote o campo 'Execution Time' em milissegundos (ms).
-- IMPORTANTE: não execute tudo em paralelo. Execute uma consulta por vez.

-- CONSULTA 1: vendas de um cliente
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM venda WHERE id_cliente = 42;

-- CONSULTA 2: vendas de um dia
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM venda WHERE venda_data = DATE '2025-06-15';

-- CONSULTA 3: vendas pagas de alto valor
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM venda
WHERE venda_status = 'PAGO' AND venda_valor >= 950.00;
