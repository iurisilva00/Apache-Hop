CREATE UNIQUE INDEX idx_metricas -- Esotu fazendo isso aqui para não bloquear as leituras, durante o refresh da view
ON silver.metricas_sinal (cidade, operadora, frequencia);