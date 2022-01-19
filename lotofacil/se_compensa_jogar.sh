#!/bin/zsh
##################################################################################
## se_compensa_jogar.sh - Script para loteria Lotofácil							##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 19/11/2021													##
## Modificações:																##
##		- 30/12/2021: Inculuido nova maneira de se obter a posição				##
##			do jogo. No entanto, o cálculo em sí está demorando					##
##			um pouco mais.														##
##			Situação diferente no caso da megasena que está mais				##
##			rápido.																##
##			Portanto desabilitarei neste programa (Lotofácil)					##
## Script que verifica se compensa ou não jogar no próximo concurso				##
##################################################################################

########################## ÚLTIMO CONCURSO #####################################

end_site="https://www.mazusoft.com.br/lotofacil/resultado.php?"
scraping=$(lynx -dump -nolist "${end_site}")

dezenas_ult_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

num_ult_concurso=$(echo "$scraping" | grep "Resultado da Lotofácil " | \
cut -d" " -f4)

# Montando jogo do último conc
for x in $(seq 1 15)
	do
	ult[$x]=$(echo $dezenas_ult_concurso | cut -d" " -f$x)
done

ult_conc=$num_ult_concurso

##### Maneira antiga de se obter a posição do jogo #####
posicao_ult=$(grep -m1 " $ult " /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/loto_base.txt | cut -d" " -f1)

##### Maneira nova de se obter a posição do jogo #####
#posicao_ult=$(./calc_posicao.sh $jogo[1] $jogo[2] $jogo[3] $jogo[4] $jogo[5] \
#$jogo[6] $jogo[7] $jogo[8] $jogo[9] $jogo[10] $jogo[11] $jogo[12] $jogo[13] \
#$jogo[14] $jogo[15])

########################### PENÚLTIMO CONCURSO #################################

num_pen_concurso=$[$ult_conc-1]
scraping=$(lynx -dump -nolist "${end_site}concurso=$num_pen_concurso")

dezenas_pen_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

# Montando jogo do penúltimo conc
for x in $(seq 1 15)
	do
	pen[$x]=$(echo $dezenas_pen_concurso | cut -d" " -f$x)
done

##### Maneira antiga de se obter a posição do jogo #####
posicao_pen=$(grep -m1 " $pen " /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/loto_base.txt | cut -d" " -f1)

##### Maneira nova de se obter a posição do jogo #####
#posicao_pen=$(./calc_posicao.sh $jogo[1] $jogo[2] $jogo[3] $jogo[4] $jogo[5] \
#$jogo[6] $jogo[7] $jogo[8] $jogo[9] $jogo[10] $jogo[11] $jogo[12] $jogo[13] \
#$jogo[14] $jogo[15])

echo

############ COMPENSA JOGAR O PRÓXIMO CONC? ###############

if [ $posicao_pen -lt $posicao_ult ] ################# MENORES #################
	then
	quant_jogos=$(head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/loto_base.txt | wc -l)
	if [ $quant_jogos -gt 1000000 ]
		then
		#echo "Quantidade de jogos possíveis: $quant_jogos"
		echo "DESTA VEZ NÃO COMPENSA JOGAR NA LOTOFACIL!"
		echo "Posição do Penultimo concurso: $posicao_pen"
		echo "Posição do Último concurso: $posicao_ult"
	else
		#echo "Quantidade de jogos possíveis: $quant_jogos"
		echo "COMPENSA! VÁ EM FRENTE COM A LOTOFACIL!"
	fi

else ############################# MAIORES ####################################
	calc=$[3268760 - $posicao_ult]
	quant_jogos=$(tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/loto_base.txt | wc -l)
	if [ $quant_jogos -gt 1000000 ]
		then
		#echo "Quantidade de jogos possíveis: $quant_jogos"
		echo "DESTA VEZ NÃO COMPENSA JOGAR NA LOTOFACIL!"
		echo "Posição do Penultimo concurso: $posicao_pen"
		echo "Posição do Último concurso: $posicao_ult"
	else
		#echo "Quantidade de jogos possíveis: $quant_jogos"
		echo "COMPENSA! VÁ EM FRENTE COM A LOTOFACIL!"
	fi
fi
echo