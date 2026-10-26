# Banco de Dados Avançado — Atividade prática: primeiro contato com índices

**Tema:** medição do desempenho de consultas antes e depois da criação de índices no PostgreSQL.  
**Modalidade:** prática individual (ou conforme orientação do professor).  
**Entrega:** relatório em PDF, com tabelas preenchidas e capturas de tela.  
**Objetivo:** observar, por meio de um experimento guiado, o efeito da criação de índices. **Não é necessário escolher índices ou interpretar tecnicamente os planos de execução.**

## O que você vai fazer

Você criará um banco com 20.000 clientes, 500 produtos e 1.200.000 vendas, executará três consultas, anotará os tempos, criará os três índices já fornecidos e repetirá exatamente as mesmas consultas. Em seguida, produzirá um relatório sobre o experimento.

**Arquivos fornecidos:** `01_base_inicial.sql`, `02_procedure_carga.sql`, `03_consultas_medicao.sql`, `04_criar_indices.sql` e `05_verificacao.sql`.

## Passo 1 — Preparar o ambiente e criar o banco

1. Abra o PostgreSQL no **pgAdmin** (ou use o terminal `psql`).
2. Crie um banco chamado `bda_indices` (pgAdmin: **Databases > Create > Database**).
3. Conecte-se ao banco `bda_indices`, abra **Query Tool** e execute todo o arquivo `01_base_inicial.sql`.
4. Confira o resultado final esperado: **20.000 clientes, 500 produtos e 0 vendas**.
5. **Evidência:** capture a tela com a consulta de contagem e o resultado.

> Neste material, “restaurar a base” significa reconstruí-la a partir do script SQL inicial, e não utilizar um arquivo binário de backup `.backup`.

## Passo 2 — Criar a stored procedure e gerar os dados

1. Ainda no banco `bda_indices`, execute todo o arquivo `02_procedure_carga.sql` para criar a procedure.
2. Em uma janela de consulta, execute **uma única vez**:

```sql
CALL gerar_vendas(1200000);
```

3. Aguarde a conclusão da execução. A carga pode demorar dependendo do computador.
4. Em seguida, execute:

```sql
ANALYZE venda;
SELECT count(*) AS total_vendas FROM venda;
```

5. O resultado esperado é **1.200.000** vendas. **Evidência:** capture a tela da contagem.

**Atenção:** não execute o `CALL` novamente, pois isso duplicará a carga. Se quiser recomeçar, execute `01_base_inicial.sql` e repita a partir do início.

## Passo 3 — Medir as consultas ANTES dos índices

1. Abra `03_consultas_medicao.sql`.
2. Execute **apenas a primeira consulta** (incluindo `EXPLAIN (ANALYZE, BUFFERS)`). No resultado, localize **`Execution Time: ... ms`** — use esse número, não o tempo da interface do pgAdmin.
3. Execute essa mesma consulta **3 vezes**, uma após a outra, e anote os três tempos.
4. Repita o procedimento para as consultas 2 e 3. Não modifique filtros, valores ou comandos.
5. **Evidências:** guarde capturas com o comando e o resultado exibindo `Execution Time`.

| Consulta | Antes: tentativa 1 (ms) | Tentativa 2 (ms) | Tentativa 3 (ms) | Média antes (ms) |
|---|---:|---:|---:|---:|
| 1 — Cliente | | | | |
| 2 — Data | | | | |
| 3 — Status e valor | | | | |

**Calcule a média** somando os três tempos e dividindo por 3.

## Passo 4 — Criar os índices indicados no roteiro

Agora execute, **sem alterar**, os três comandos de `04_criar_indices.sql`:

```sql
CREATE INDEX idx_venda_cliente ON venda (id_cliente);
CREATE INDEX idx_venda_data ON venda (venda_data);
CREATE INDEX idx_venda_status_valor ON venda (venda_status, venda_valor);
ANALYZE venda;
```

Execute depois o arquivo `05_verificacao.sql` para verificar se os índices estão presentes.

**Evidência:** capture uma tela que demonstre a criação ou a listagem dos índices.

**Observação:** se aparecer erro de índice já existente, verifique se você executou este passo anteriormente. Não crie o mesmo índice duas vezes.

## Passo 5 — Medir as consultas DEPOIS dos índices

1. Volte ao **mesmo** arquivo `03_consultas_medicao.sql`.
2. Repita, sem mudanças, cada uma das três consultas **3 vezes**.
3. Anote o valor de `Execution Time` de cada execução e calcule a nova média.
4. Faça novas capturas de tela mostrando os tempos.

| Consulta | Depois: tentativa 1 (ms) | Tentativa 2 (ms) | Tentativa 3 (ms) | Média depois (ms) |
|---|---:|---:|---:|---:|
| 1 — Cliente | | | | |
| 2 — Data | | | | |
| 3 — Status e valor | | | | |

## Passo 6 — Comparar e calcular os resultados

Preencha a tabela usando as médias medidas **no seu computador**:

| Consulta | Média antes (ms) | Média depois (ms) | Diferença (ms) | Redução (%) |
|---|---:|---:|---:|---:|
| 1 — Cliente | | | | |
| 2 — Data | | | | |
| 3 — Status e valor | | | | |

**Fórmulas:**

- Diferença = Média antes − Média depois.
- Redução (%) = `(Média antes − Média depois) / Média antes × 100`.

**Exemplo apenas ilustrativo:** se uma média cair de 100 ms para 20 ms, a diferença é 80 ms e a redução é 80%. **Não utilize esse exemplo como resultado real.**

O tempo depende do computador, cache e outros processos. Uma consulta isolada pode não ficar mais rápida; registre o que realmente observou, sem modificar os resultados para parecerem melhores.

## Passo 7 — Produzir o relatório

Entregue **um único PDF** contendo obrigatoriamente:

1. **Capa:** disciplina, título, nome, turma e data.
2. **Objetivo:** descreva em 3–5 linhas o que o experimento procura demonstrar.
3. **Ambiente utilizado:** versão do PostgreSQL, sistema operacional e ferramenta usada (pgAdmin ou psql).
4. **Montagem do banco e carga:** informe as quantidades de clientes, produtos e vendas; inclua capturas.
5. **Medição antes:** preencha a primeira tabela de tempos e inclua evidências.
6. **Criação dos índices:** liste os três comandos `CREATE INDEX` executados e inclua evidência.
7. **Medição depois:** preencha a segunda tabela de tempos e inclua evidências.
8. **Comparação:** preencha a tabela final (médias, diferenças e redução percentual).
9. **Observações e conclusão:** responda brevemente:
   - Qual consulta apresentou a maior redução percentual de tempo?
   - As três consultas ficaram mais rápidas, considerando as médias?
   - O que você observou ao repetir os testes?
   - Em suas palavras, qual foi a principal lição do experimento?

**Nome sugerido do arquivo:** `BDA_Indices_NomeSobrenome.pdf`.
**Enviar o documento na atividade do AVA de acordo com os prazos nela definidos.**

## Orientações para problemas comuns

- **`relation "venda" does not exist`**: confira se está conectado ao banco `bda_indices` e se executou `01_base_inicial.sql`.
- **`procedure gerar_vendas(integer) does not exist`**: execute primeiro `02_procedure_carga.sql`.
- **Vendas acima de 1.200.000**: provavelmente o `CALL` foi executado mais de uma vez. Recomece pelo arquivo `01_base_inicial.sql`.
- **`relation idx_venda_cliente already exists`**: algum índice já foi criado; confira `05_verificacao.sql`.
- **Pouca ou nenhuma melhoria**: registre os tempos reais, confira se os índices foram criados e se as consultas foram repetidas sem alterações.
