-- Criando a tabela de dimensão de tempo.
CREATE TABLE gold.dim_tempo (
    id_tempo SERIAL PRIMARY KEY,
    data_completa DATE NOT NULL UNIQUE,
    ano INT NOT NULL,
    mes INT NOT NULL,
    dia INT NOT NULL,
    trimestre INT NOT NULL,
    nome_mes VARCHAR(20) NOT NULL,
    dia_da_semana VARCHAR(20) NOT NULL
);
--Populando tabela de dimensão de tempo
INSERT INTO gold.dim_tempo (data_completa, ano, mes, dia, trimestre, nome_mes, dia_da_semana)
SELECT
    datum AS data_completa,
    EXTRACT(YEAR FROM datum) AS ano,
    EXTRACT(MONTH FROM datum) AS mes,
    EXTRACT(DAY FROM datum) AS dia,
    EXTRACT(QUARTER FROM datum) AS trimestre,
    TO_CHAR(datum, 'TMMonth') AS nome_mes,
    TO_CHAR(datum, 'TMDay') AS dia_da_semana
FROM GENERATE_SERIES(
    '2024-01-01'::DATE,
    '2026-12-31'::DATE,
    '1 day'::INTERVAL
) AS datum;