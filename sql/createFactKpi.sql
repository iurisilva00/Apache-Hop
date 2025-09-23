CREATE TABLE gold.fact_kpi_teste_portadora (
    -- Chaves Substitutas
    cod_tempo INT NOT NULL REFERENCES gold.dim_tempo(id_tempo), -- A dim_tempo deve usar id_tempo
    cod_cidade INT NOT NULL REFERENCES gold.dim_cidade(token),
    cod_operadora INT NOT NULL REFERENCES gold.dim_operadora(token),
    cod_frequencia INT NOT NULL REFERENCES gold.dim_frequencia(token), -- Verifique se o nome é 'token' aqui também
    cod_evento INT NOT NULL REFERENCES gold.dim_evento(token),       -- Verifique se o nome é 'token' aqui também

    -- Métricas Agregadas
    avg_rsrp NUMERIC(10, 2),
    avg_rsrq NUMERIC(10, 2),
    avg_sinr NUMERIC(10, 2),
    total_medicoes INT,

    PRIMARY KEY (cod_tempo, cod_cidade, cod_operadora, cod_frequencia, cod_evento)
);