CREATE TABLE gold.dim_cidade (
    token SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE gold.dim_operadora (
    token SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE gold.dim_frequencia (
    token SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,      -- ex: 'LTE_700MHz'
    tecnologia VARCHAR(10) NOT NULL,        -- ex: '4G', '5G'
    banda VARCHAR(10) NOT NULL            -- ex: 'B28', 'n78'

);
CREATE TABLE gold.dim_frequencia (
    token SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,      -- ex: 'LTE_700MHz'
    tecnologia VARCHAR(10) NOT NULL,        -- ex: '4G', '5G'
    banda VARCHAR(10) NOT NULL            -- ex: 'B28', 'n78'

);
CREATE TABLE gold.dim_evento (
    token SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE      -- ex: 'Ping', 'HTTP'

);