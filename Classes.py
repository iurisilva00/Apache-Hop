import re
import unicodedata

class StringFormatter:
    """
    Classe utilitária para formatação de strings, incluindo conversão para snake_case.
    """

    @staticmethod
    def to_snake_case(name: str) -> str:
        """
        Converte uma string para o formato snake_case.

        Exemplos:
            "NomeDoUsuário"   → "nome_do_usuario"
            "Data de Cadastro!" → "data_de_cadastro"
            "ValorTotalR$2024" → "valor_total_r_2024"

        Args:
            name (str): String de entrada a ser convertida.

        Returns:
            str: String convertida em snake_case.
        """
        if not isinstance(name, str):
            raise TypeError("O parâmetro 'name' deve ser uma string.")

        # Remove acentos
        nfkd = unicodedata.normalize('NFKD', name)
        name = ''.join([c for c in nfkd if not unicodedata.combining(c)])

        # Substitui espaços, hífens e outros separadores por underscore
        name = re.sub(r'[\s\-\/\.\,\:\;\+\=\@\#\$\%\&\*\(\)\[\]\{\}]+', '_', name)

        # Insere underscore antes de letras maiúsculas (exceto no início)
        name = re.sub(r'(?<!^)(?=[A-Z])', '_', name)

        # Remove underscores duplicados e dos extremos
        name = re.sub(r'_+', '_', name)
        name = name.strip('_')

        # Converte tudo para minúsculo
        return name.lower()