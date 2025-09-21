
WITH all_raw_frequencies AS (
    SELECT tecnologia, banda
    FROM silver.nr_3500mhz
    WHERE tecnologia IS NOT NULL AND banda IS NOT NULL

    UNION

    SELECT tecnologia, banda
    FROM silver.lte_1800mhz
    WHERE tecnologia IS NOT NULL AND banda IS NOT NULL

    UNION

    SELECT tecnologia, banda
    FROM silver.lte_700mhz
    WHERE tecnologia IS NOT NULL AND banda IS NOT NULL
)

INSERT INTO gold.dim_frequencia (frequencia, tecnologia, banda)
SELECT
    substring(banda FROM '\((.*)\)') AS frequencia, 
    tecnologia,                                   
    split_part(banda, ' ', 1) AS banda            
FROM all_raw_frequencies;