#!/bin/zsh
##################################################################################
## estatistica1.sh - Script para loteria Quina					##
## Autor: Benedito Del Vecchio Junior						##
## Data de criação: 29/11/2021							##
## Descrição:									##
##		- Acessa o site www.mazusoft.com.br/quina			##
##		- Captura do primeiro concurso até o concurso nº5716		##
##		- Captura as dezenas de cada concurso				##
##		- Captura a quantidade de impares de cada concurso		##
## Requisitos:									##
##		- Necessita do programa lynx instalado na máquina		##
## Exemplo de uso: ./estatistica1.sh						##
##################################################################################
echo -n > estatistica1.txt
clear
for x in $(seq 1 5716)
do

end_site="https://www.mazusoft.com.br/quina/resultado.php?concurso="$x""
scraping=$(lynx -dump -nolist "${end_site}")

num_ult_concurso=$(echo "$scraping" | grep "Resultado da Quina " | \
cut -d" " -f4)

dezenas_ult_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

quant_impar=$(echo "$scraping" | grep "Concurso: " | sed 's/.\{3\}//' \
| cut -d"|" -f2 | cut -d":" -f3)

echo "$num_ult_concurso"
echo "$num_ult_concurso $dezenas_ult_concurso $quant_impar" >> estatistica1.txt
done

# expressão regular
# apaga os 3 primeiros caracteres
# 's/.\{3\}//'