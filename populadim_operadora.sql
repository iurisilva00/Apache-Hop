INSERT INTO gold.dim_operadora (nome)
SELECT operadora AS nome
FROM silver.nr_3500mhz
WHERE operadora IS NOT NULL

UNION

SELECT operadora
FROM silver.lte_1800mhz
WHERE operadora IS NOT NULL

UNION

SELECT operadora
FROM silver.lte_700mhz
WHERE operadora IS NOT NULL

ORDER BY nome;