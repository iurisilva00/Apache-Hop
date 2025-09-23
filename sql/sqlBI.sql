SELECT
    -- Atributos da Dimensão Tempo
    dt.data_completa,
    dt.ano,
    dt.mes,
    dt.nome_mes,
    dt.dia_da_semana,

    -- Atributos da Dimensão Cidade
    dc.nome AS cidade,

    -- Atributos da Dimensão Operadora
    dope.nome AS operadora,

    -- Atributos da Dimensão Frequência
    df.frequencia,
    df.tecnologia,
    df.banda,

    -- Atributos da Dimensão Evento
    de.nome AS evento,

    -- Métricas da Tabela Fato
    f.avg_rsrp,
    f.avg_rsrq,
    f.avg_sinr,
    f.total_medicoes

FROM gold.fact_kpi_teste_portadora f
-- Juntando a fato com as dimensões usando as chaves corretas
JOIN gold.dim_tempo dt ON f.cod_tempo = dt.id_tempo
JOIN gold.dim_cidade dc ON f.cod_cidade = dc.token
JOIN gold.dim_operadora dope ON f.cod_operadora = dope.token
JOIN gold.dim_evento de ON f.cod_evento = de.token
JOIN gold.dim_frequencia df ON f.cod_frequencia = df.token
