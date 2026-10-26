-- Criar a procedure e, depois, chamar CALL gerar_vendas(1200000);
-- Execute a chamada apenas UMA VEZ para manter os resultados comparáveis.
CREATE OR REPLACE PROCEDURE gerar_vendas(p_quantidade integer, p_lote integer DEFAULT 100000)
LANGUAGE plpgsql
AS $$
DECLARE
    v_inicio integer := 1;
    v_fim integer;
BEGIN
    IF p_quantidade < 1 OR p_lote < 1 THEN
        RAISE EXCEPTION 'Quantidade e lote devem ser positivos';
    END IF;

    WHILE v_inicio <= p_quantidade LOOP
        v_fim := LEAST(v_inicio + p_lote - 1, p_quantidade);
        INSERT INTO venda (id_cliente, id_produto, venda_data, venda_status, venda_valor)
        SELECT
            1 + floor(random() * 20000)::integer,
            1 + floor(random() * 500)::integer,
            date '2024-01-01' + floor(random() * 730)::integer,
            (ARRAY['PAGO','PENDENTE','CANCELADO','ENVIADO'])[1 + floor(random() * 4)::integer],
            round((10 + random() * 990)::numeric, 2)
        FROM generate_series(v_inicio, v_fim);
        RAISE NOTICE 'Registros inseridos até: %', v_fim;
        v_inicio := v_fim + 1;
    END LOOP;
END;
$$;

-- Descomente a linha abaixo para executar a carga:
-- CALL gerar_vendas(1200000);
-- Ao terminar a carga, executar em seguida: ANALYZE venda;
