CREATE MATERIALIZED VIEW silver.metricas_sinal AS


WITH dados_unificados AS (
    SELECT cidade, operadora, tecnologia, banda, rsrp, rsrq, sinr
    FROM silver.nr_3500mhz
    UNION ALL
    SELECT cidade, operadora, tecnologia, banda, rsrp, rsrq, sinr
    FROM silver.lte_1800mhz
    UNION ALL
    SELECT cidade, operadora, tecnologia, banda, rsrp, rsrq, sinr
    FROM silver.lte_700mhz
)
-- 2. A consulta principal que define a visão materializada
SELECT
    cidade,
    operadora,
    (tecnologia || '_' || split_part(banda, ' ', 1)) AS frequencia,

    -- Métricas para RSRP
    AVG(rsrp) AS media_rsrp,
    MIN(rsrp) AS min_rsrp,
    MAX(rsrp) AS max_rsrp,

    -- Métricas para RSRQ
    AVG(rsrq) AS media_rsrq,
    MIN(rsrq) AS min_rsrq,
    MAX(rsrq) AS max_rsrq,

    -- Métricas para SINR
    AVG(sinr) AS media_sinr,
    MIN(sinr) AS min_sinr,
    MAX(sinr) AS max_sinr,

    -- Contagem de registros
    COUNT(*) AS total_medicoes

FROM dados_unificados
WHERE
    cidade IS NOT NULL AND
    operadora IS NOT NULL AND
    banda IS NOT NULL AND
    rsrp IS NOT NULL --garantir que os campos de métrica não sejam nulos
GROUP BY
    cidade,
    operadora,
    frequencia
ORDER BY
    cidade, operadora, frequencia;