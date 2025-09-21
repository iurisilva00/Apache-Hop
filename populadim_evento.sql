INSERT INTO gold.dim_evento (nome)
SELECT evento AS nome
FROM silver.nr_3500mhz
WHERE evento IS NOT NULL

UNION

SELECT evento
FROM silver.lte_1800mhz
WHERE evento IS NOT NULL

UNION

SELECT evento
FROM silver.lte_700mhz
WHERE evento IS NOT NULL

ORDER BY nome;