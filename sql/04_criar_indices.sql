-- Execute apenas DEPOIS de registrar as medições iniciais.
-- Os alunos devem COPIAR e EXECUTAR estes índices; não precisam planejá-los.
CREATE INDEX idx_venda_cliente ON venda (id_cliente);
CREATE INDEX idx_venda_data ON venda (venda_data);
CREATE INDEX idx_venda_status_valor ON venda (venda_status, venda_valor);

-- Atualiza estatísticas para que o otimizador possa considerar os índices.
ANALYZE venda;
