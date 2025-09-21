import pandas as pd #importa o pandas para criação do dataframe e do tratamento de dados iniciais
import openpyxl # importa o openpyxl para ler os arquivos que tem xls
from Classes import StringFormatter

# Tratando a Primeira Planilha

df_LTE_700MHz = pd.read_excel(r"C:\Users\iuri.silva\Downloads\teste_portadora_multifreq_nomes.xlsx", sheet_name="LTE_700MHz", engine="openpyxl") # Usa o engine para dizer a biblioteca que desejo utilizar a engenharia do openpyxl

print(df_LTE_700MHz.shape) #conferir o tamanho da sheet

print("Tipo das minhas colunas", df_LTE_700MHz.info()) #Analisando os tipos de colunas

print("Nomes das colunas", df_LTE_700MHz.columns) #Analisando os nomes das colunas

"""
Utilizei a opção de criar uma classe para mantermos uma boa separação do código, tratei também todas as colunas para evitar que em algum momento tenhamos erros.
"""
df_LTE_700MHz.columns = [StringFormatter.to_snake_case(col) for col in df_LTE_700MHz.columns]

print("Nomes das colunas", df_LTE_700MHz.columns)

##Lendo a segunda planilha

df_LTE_1800MHz= pd.read_excel(r"C:\Users\iuri.silva\Downloads\teste_portadora_multifreq_nomes.xlsx", sheet_name="LTE_1800MHz", engine="openpyxl")

print(df_LTE_1800MHz.shape) #conferir o tamanho da sheet

print("Tipo das minhas colunas", df_LTE_1800MHz.info()) #Analisando os tipos de colunas

print("Nomes das colunas", df_LTE_1800MHz.columns) #Analisando os nomes das colunas

df_LTE_1800MHz.columns = [StringFormatter.to_snake_case(col) for col in df_LTE_1800MHz.columns]

print("Nomes das colunas", df_LTE_1800MHz.columns)




##Lendo a Terceira planilha

df_NR_3500MHz= pd.read_excel(r"C:\Users\iuri.silva\Downloads\teste_portadora_multifreq_nomes.xlsx", sheet_name="NR_3500MHz", engine="openpyxl")

print(df_NR_3500MHz.shape) #conferir o tamanho da sheet

print("Tipo das minhas colunas", df_NR_3500MHz.info()) #Analisando os tipos de colunas

print("Nomes das colunas", df_NR_3500MHz.columns) #Analisando os nomes das colunas

df_NR_3500MHz.columns = [StringFormatter.to_snake_case(col) for col in df_NR_3500MHz.columns]

print("Nomes das colunas", df_NR_3500MHz.columns)


dfs = {
    'nr_3500mhz': df_NR_3500MHz,
    'lte_1800mhz': df_LTE_1800MHz,
    'lte_700mhz': df_LTE_700MHz
}



for nome_arquivo, df in dfs.items():

    # Garantindo data_evento como datetime 
    df['data_evento'] = pd.to_datetime(df['data_evento'])

    # Salva CSV limpo
    df.to_csv(f'{nome_arquivo}.csv', index=False, encoding='utf-8')

    print(f"✅ {nome_arquivo}.csv salvo com tipos padronizados.")
