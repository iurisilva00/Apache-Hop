📡 Pipeline de Análise e Engenharia de Dados de Telecomunicações
Este projeto demonstra um pipeline completo de engenharia e análise de dados, desde o processamento inicial dos dados brutos até a visualização final em painéis de BI. O foco é em dados de telecomunicações, mostrando como transformar arquivos brutos em informações estruturadas, confiáveis e prontas para análise estratégica.

⚙️ Tecnologias Utilizadas
Python
Extração, limpeza e padronização inicial dos dados
Pandas + OpenPyXL
Leitura de planilhas
.xls
e conversão para
.csv
PostgreSQL
Armazenamento estruturado em camadas (raw → silver → gold)
Apache Hop
Orquestração ETL: ingestão, transformação e modelagem dimensional
Power BI
Visualização de dados e criação de dashboards analíticos
Ambiente Virtual (venv)
Isolamento e controle de dependências Python
🚀 Visão Geral do Projeto
O pipeline é dividido em três fases principais, seguindo boas práticas de arquitetura de dados:

1️⃣ Preparação dos Dados (Python)
Leitura do Excel:
Arquivo .xls com 3 planilhas lido via pandas.read_excel(engine='openpyxl').
Padronização:
Todas as colunas convertidas para snake_case para consistência e interoperabilidade.
Exportação para CSV:
Cada planilha transformada e salva como arquivo .csv individual — formato ideal para ingestão em bancos de dados.
✅ Saída: 3 arquivos CSV prontos para ingestão (nr_3500mhz.csv, lte_1800mhz.csv, lte_700mhz.csv) 

2️⃣ Modelagem e Ingestão (PostgreSQL & Apache Hop)
🏗️ Estrutura do Banco de Dados (telecom)
sql


1
2
3
CREATE SCHEMA raw;     -- Dados brutos (ingestão direta dos CSVs)
CREATE SCHEMA silver;  -- Dados transformados e limpos
CREATE SCHEMA gold;    -- Dados modelados para análise (fatos + dimensões)
🔄 Pipelines de ETL no Apache Hop
Ingestão na camada raw:
Pipelines com prefixo Cs_*.hpl carregam os CSVs diretamente nas tabelas raw.
Transformação para silver:
Pipelines com prefixo transform_*.hpl aplicam:
Conversão de tipos (ex: VARCHAR → TIMESTAMP, NUMERIC)
Geração de hash_registro (baseado em: data_do_evento, latitude, longitude, tecnologia, banda, earfcn, pci, evento, cidade)
Adição da coluna data_ingestao
Cálculo de métricas de qualidade: RSRP, RSRQ, SINR
Modelagem Dimensional na gold:
Tabelas criadas:
dim_cidade, dim_operadora, dim_frequencia, dim_evento, dim_tempo
fato_medicoes (tabela de fatos com chaves estrangeiras para as dimensões)
Atualização Contínua:
Criada VIEW + MATERIALIZED VIEW com REFRESH agendado para manter os dados sempre atualizados.
3️⃣ Análise e Visualização (Power BI)
Conexão direta com a camada gold do PostgreSQL.
Dashboards criados:
📊 Análise Geral: Visão consolidada de medições por localidade e operadora.
📈 Análise por Medição: Detalhamento por tipo de evento (Ping, HTTP, Voz, etc).
📶 Análise por Qualidade de Sinal: Performance da rede com base em RSRP, RSRQ e SINR.
📁 Estrutura de Pastas


1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
├── HOP/
│   ├── Cs_*.hpl             → Pipelines de ingestão (CSV → raw)
│   └── transform_*.hpl      → Pipelines de transformação (raw → silver → gold)
│
├── SQL/
│   ├── create_*.sql         → Scripts de criação de schemas, tabelas e views
│   └── popula_*.sql         → Scripts de população das dimensões na camada gold
│
├── data/
│   ├── raw/                 → Arquivos CSV gerados pelo Python
│   └── (outros dados brutos)
│
├── scripts/
│   └── preparacao_dados.py  → Script Python para leitura e padronização
│
└── README.md                ← Você está aqui!
🛠️ Como Usar este Repositório
Clone o repositório:
bash


1
git clone https://github.com/seu-usuario/nome-do-repo.git
Configure o ambiente Python:
bash


1
2
3
python -m venv venv
venv\Scripts\activate  # Windows
pip install -r requirements.txt
Execute o script de preparação:
bash


1
python scripts/preparacao_dados.py
Gera os arquivos .csv na pasta data/raw/. 
Configure o PostgreSQL:
Crie o banco telecom.
Execute os scripts SQL de criação (SQL/create_*.sql).
Execute os pipelines no Apache Hop:
Abra o Hop (hop-gui.bat).
Execute os pipelines na ordem:
Cs_*.hpl → carrega dados na raw
transform_*.hpl → processa para silver e gold
Conecte o Power BI:
Abra o arquivo .pbix.
Conecte ao banco telecom → schema gold.
Atualize os dados e explore os dashboards!