INSERT INTO gold.dim_cidade (nome)
SELECT DISTINCT cidade AS nome 
FROM silver.nr_3500mhz
WHERE cidade IS NOT NULL

UNION

SELECT DISTINCT cidade
FROM silver.lte_1800mhz
WHERE cidade IS NOT NULL

UNION

SELECT DISTINCT cidade
FROM silver.lte_700mhz
WHERE cidade IS NOT NULL

ORDER BY nome;