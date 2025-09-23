### README: Pipeline de Análise e Engenharia de Dados de Telecomunicações

Este projeto demonstra um pipeline completo de **análise e engenharia de dados**, desde o processamento inicial de arquivos brutos até a visualização final em um painel de Business Intelligence (BI). O foco é em dados de telecomunicações, mostrando como transformar informações complexas em insights valiosos.

---

### ⚙️ Tecnologias Utilizadas

* **Python:** Para a extração e limpeza inicial dos dados.
* **PostgreSQL:** Banco de dados relacional para armazenamento dos dados em camadas.
* **Apache Hop:** Ferramenta de ETL (Extração, Transformação e Carga) para orquestrar o fluxo de dados.
* **Power BI:** Para a criação dos painéis de análise e visualização.
* **Ambiente Virtual (`venv`):** Para isolar as dependências do projeto em Python.

---

### 🚀 Visão Geral do Projeto

O projeto segue um fluxo lógico, dividido em três fases principais:

#### **1. Preparação dos Dados (Python)**

1.  **Leitura do Excel:** O projeto começou com um arquivo `.xls` contendo três planilhas. Usei o **Python** com a biblioteca Pandas e a `engine='openpyxl'` para ler cada uma delas.
2.  **Padronização:** As colunas foram padronizadas para o formato `snake_case`, garantindo consistência.
3.  **Conversão para CSV:** Cada planilha foi transformada e salva como um arquivo `.csv` individual, um formato ideal para ingestão em bases de dados.

#### **2. Pipelines de ETL no Apache Hop**

O banco de dados PostgreSQL foi estruturado com três schemas (`raw`, `silver`, e `gold`) para organizar o fluxo de dados.

* **Ingestão na camada `raw`:**
    * Pipelines com prefixo `cs*.hpl` carregam os arquivos CSV diretamente nas tabelas da camada `raw`.

* **Transformação para `silver`:**
    * Pipelines com prefixo `transform*.hpl` aplicam as seguintes transformações:
        * Conversão de tipos (ex: VARCHAR → TIMESTAMP, NUMERIC).
        * Geração de `hash_registro` (baseado em: `data_do_evento`, `latitude`, `longitude`, `tecnologia`, `banda`, `earfcn`, `pci`, `evento`, `cidade`,`RSRP`, `RSRQ`, `SINR`).
        * Adição da coluna `data_ingestao`.


* **Modelagem Dimensional na `gold`:**
    * Tabelas criadas: `dim_cidade`, `dim_operadora`, `dim_frequencia`, `dim_evento`, `dim_tempo`.
    * `fato_medicoes`: Tabela de fatos com chaves estrangeiras para as dimensões.

* **Atualização Contínua:**
    * Foi criada uma `VIEW` e uma `MATERIALIZED VIEW` com `REFRESH` agendado para manter os dados sempre atualizados, garantindo a consistência na análise.

#### **3. Análise e Visualização (Power BI)**

* **Conexão direta** com a camada `gold` do PostgreSQL.
* **Dashboards criados:**
    * 📊 **Análise Geral:** Visão consolidada de medições por localidade e operadora.
    * 📶 **Análise por Qualidade de Sinal:** Performance da rede com base em `RSRP`, `RSRQ` e `SINR`.

---

### 📁 Estrutura de Pastas
├── HOP/
│   ├── Cs_.hpl             → Pipelines de ingestão (CSV → raw)
│   └── transform_.hpl      → Pipelines de transformação (raw → silver → gold)
│
├── SQL/
│   ├── create_.sql         → Scripts de criação de schemas, tabelas e views
│   └── popula_.sql         → Scripts de população das dimensões na camada gold
│
├── data/
│   ├── raw/                 → Arquivos CSV gerados pelo Python
│   └── (outros dados brutos)
│
├── scripts/
│   └── preparacao_dados.py  → Script Python para leitura e padronização
│
└── README.md                ← Você está aqui!

