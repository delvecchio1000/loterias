#!/bin/zsh
##################################################################################
## se_compensa_jogar.sh - Script para loteria Quina								##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 19/11/2021													##
## Modificações:																##
##		- 30/12/2021: Inculuido nova maneira de se obter a posição				##
##			do jogo. No entanto, apesar do programa deixar de 					##
##			acessar cinco arquivos de cinco milhões de linhas					##
##			cada, o cálculo em sí está demorando um pouco mais.					##
##			Situação diferente no caso da megasena que está mais				##
##			rápido.																##
##			Portanto deixarei desabilitado neste programa (Quina)				##
## Script que verifica se compensa ou não jogar no próximo concurso				##
##################################################################################

####################### INICIO DADOS DO ÚLTIMO CONCURSO ########################
end_site="https://www.mazusoft.com.br/quina/resultado.php?"
scraping=$(lynx -dump -nolist "${end_site}")

dezenas_ult_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

num_ult_concurso=$(echo "$scraping" | grep "Resultado da Quina " | \
cut -d" " -f4)

#echo "Número do último concurso: "$num_ult_concurso""
#echo "Dezenas do último concurso: "$dezenas_ult_concurso""

############### Buscando a posição do jogo do último concurso ##################
echo -n > posicao.txt
for j in $(seq 1 5)
	do
	jogo[$j]=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
	tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | \
	sed 's/03/3/g' | sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | \
	sed 's/07/7/g' | sed 's/08/8/g' | sed 's/09/9/g' | cut -d" " -f"$j")
done

#### Maneira antiga de se obter a posição do jogo ####

for x in /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_5_10.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_10_15.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_15_20.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_20_mais.txt
	do
	posicao_ult=$(grep -m1 " $jogo" "$x" | cut -d" " -f1)
	if [ "$posicao_ult" > 0 ]
		then
		#echo "Posição do jogo do último concurso: "$posicao_ult""
		echo "$posicao_ult" > posicao.txt # Esta variavel está se 
		# apagando ao sair deste laço for. Portanto tive que 
		# salvá-la em um arquivo externo.
	fi
done
posicao_ult=$(cat posicao.txt) # Aqui recupero a variavel novamente

##### Maneira nova de se obter a posição do jogo #####
#posicao_ult=$(./calc_posicao.sh $jogo[1] $jogo[2] $jogo[3] $jogo[4] $jogo[5])

##################### TÉRMINO DADOS DO ÚLTIMO CONCURSO #########################

####################### INICIO DADOS DO PENÚLTIMO CONCURSO #####################
num_pen_concurso=$[$num_ult_concurso-1]
scraping=$(lynx -dump -nolist "${end_site}concurso=$num_pen_concurso")

dezenas_pen_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')


echo
#echo "Número do penúltimo concurso: "$num_pen_concurso""
#echo "Dezenas do penúltimo concurso: "$dezenas_pen_concurso""

############## Buscando a posição do jogo do penúltimo concurso ################
echo -n > posicao.txt
for j in $(seq 1 5)
	do
	jogo[$j]=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
	tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | \
	sed 's/03/3/g' | sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | \
	sed 's/07/7/g' | sed 's/08/8/g' | sed 's/09/9/g' | cut -d" " -f"$j")
done

#### Maneira antiga de se obter a posição do jogo ####

for x in /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_5_10.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_10_15.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_15_20.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_20_mais.txt
	do
	posicao_pen=$(grep -m1 " $jogo" "$x" | cut -d" " -f1)
	if [ "$posicao_pen" > 0 ]
		then
		#echo "Posição do jogo do penúltimo concurso: "$posicao_pen""
		echo "$posicao_pen" > posicao.txt # Esta variavel estava se 
		# apagando ao sair deste laço for. Portanto tive que 
		# salvá-la em um arquivo externo.	
	fi
done
posicao_pen=$(cat posicao.txt) # Aqui recupero a variavel novamente

##### Maneira nova de se obter a posição do jogo #####
#posicao_pen=$(./calc_posicao.sh $jogo[1] $jogo[2] $jogo[3] $jogo[4] $jogo[5])

echo

############ COMPENSA JOGAR O PRÓXIMO CONC? ###############

if [ $posicao_pen -lt $posicao_ult ] ################# MENORES #################
	then
	
	if [ $posicao_ult -lt 8000000 ]
		then
		echo "COMPENSA! VÁ EM FRENTE COM A QUINA!"
	else
		echo "DESTA VEZ NÃO COMPENSA JOGAR NA QUINA!"
		echo "Posição do Penultimo concurso: $posicao_pen"
		echo "Posição do Último concurso: $posicao_ult"
	fi

else ############################# MAIORES ####################################
	
	if [ $posicao_ult -gt 16000000 ]
		then
		echo "COMPENSA! VÁ EM FRENTE COM A QUINA!"
	else
		echo "DESTA VEZ NÃO COMPENSA JOGAR NA QUINA!"
		echo "Posição do Penultimo concurso: $posicao_pen"
		echo "Posição do Último concurso: $posicao_ult"
	fi
fi
echo