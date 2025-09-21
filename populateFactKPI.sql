INSERT INTO gold.fact_kpi_teste_portadora (
    cod_tempo, cod_cidade, cod_operadora, cod_frequencia, cod_evento,
    avg_rsrp, avg_rsrq, avg_sinr, total_medicoes
)
WITH dados_unificados AS (
    SELECT data_evento, cidade, operadora, evento, tecnologia, banda, rsrp, rsrq, sinr
    FROM silver.nr_3500mhz
    UNION ALL
    SELECT data_evento, cidade, operadora, evento, tecnologia, banda, rsrp, rsrq, sinr
    FROM silver.lte_1800mhz
    UNION ALL
    SELECT data_evento, cidade, operadora, evento, tecnologia, banda, rsrp, rsrq, sinr
    FROM silver.lte_700mhz
)
SELECT
    dt.id_tempo,
    dc.token,
    dope.token,
    df.token,
    de.token,
    AVG(du.rsrp),
    AVG(du.rsrq),
    AVG(du.sinr),
    COUNT(*)
FROM dados_unificados du
JOIN gold.dim_tempo dt ON CAST(du.data_evento AS DATE) = dt.data_completa
JOIN gold.dim_cidade dc ON du.cidade = dc.nome
JOIN gold.dim_operadora dope ON du.operadora = dope.nome
JOIN gold.dim_evento de ON du.evento = de.nome

JOIN gold.dim_frequencia df ON substring(du.banda FROM '\((.*)\)') = df.frequencia
GROUP BY
    dt.id_tempo,
    dc.token,
    dope.token,
    df.token,
    de.token;