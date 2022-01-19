#!/bin/zsh
##################################################################################
## mega_da_virada.sh - Script para loteria Megasena								##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 20/12/2021													##
## Descrição:																	##
##		- Captura as dezenas do último concurso									##
##		- Captura o número do último concurso									##
##		- Descobre a posição do jogo do último concurso							##
##		- Captura as dezenas do penúltimo concurso								##
##		- Captura o número do penúltimo concurso								##
##		- Descobre a posição do jogo do penúltimo concurso						##
##		- Utiliza a técnica R12 (retira 12 números do universo)					##
##		- Monta o arquivo /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt contendo os jogos filtrados				##
##		- Filtros utilizados: 												 	##
##			- R12																##
##			- quant de ímpares (só jogos com 2,3 ou 4 ímpares)					##
##			- variação do fluxo de jogo (entre penultimo e ult)					##
##			- jogos entre 3.710.323 e 7.410.323, ou								##
##			- jogos entre 40.710.323 e 44.410.323, ou							##
##			- jogos entre 14.810.323 e 33.310.323								##
##		- Aposta, guardando os jogos no arquivo mega_virada.txt					##
## Requisitos:																	##
##		- Necessita do programa lynx instalado na máquina						##
## Exemplo de uso: ./mega_da_virada.sh											##
## Modificações:																##
##		- 30/12/2021: Incluida nova maneira de se obter a posição				##
##			do jogo. Tornou a execução do programa mais rápido					##
##################################################################################

printf "Digite a quantidade de jogos ( MÚLTIPLO DE 3! ): "
read q

#q=15 # quantidade de apostas ( MÚLTIPLO DE 3! )
quant_apostas=$q
####################### INICIO DADOS DO ÚLTIMO CONCURSO ########################
end_site="https://www.mazusoft.com.br/mega/resultado.php?"
scraping=$(lynx -dump -nolist "${end_site}")

dezenas_ult_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

num_ult_concurso=$(echo "$scraping" | grep "Resultado da MegaSena " | \
cut -d" " -f4)

echo "Dezenas do último concurso: "$dezenas_ult_concurso""
echo "Número do último concurso: "$num_ult_concurso""

############### Buscando a posição do jogo do último concurso ##################

for j in $(seq 1 6)
	do
	jogo[$j]=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
	tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | \
	sed 's/03/3/g' | sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | \
	sed 's/07/7/g' | sed 's/08/8/g' | sed 's/09/9/g' | cut -d" " -f"$j")
done

##### Maneira antiga de se obter a posição do jogo #####
#echo -n > posicao.txt
#posicao_ult=$(grep " $jogo" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10.txt \
#/home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30.txt \
#/home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50.txt \
#/home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais.txt | cut -d" " -f1 | cut -d":" -f2)

##### Maneira nova de se obter a posição do jogo #####
posicao_ult=$(./calc_posicao.sh $jogo[1] $jogo[2] $jogo[3] $jogo[4] $jogo[5] \
$jogo[6])

echo "Posição do jogo do último concurso: $posicao_ult"

##################### TÉRMINO DADOS DO ÚLTIMO CONCURSO #########################

####################### INICIO DADOS DO PENÚLTIMO CONCURSO #####################
num_pen_concurso=$[$num_ult_concurso-1]
scraping=$(lynx -dump -nolist "${end_site}concurso=$num_pen_concurso")

dezenas_pen_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')


echo
echo "Dezenas do penúltimo concurso: "$dezenas_pen_concurso""
echo "Número do penúltimo concurso: "$num_pen_concurso""

############## Buscando a posição do jogo do penúltimo concurso ################
for j in $(seq 1 6)
	do
	jogo[$j]=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
	tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | \
	sed 's/03/3/g' | sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | \
	sed 's/07/7/g' | sed 's/08/8/g' | sed 's/09/9/g' | cut -d" " -f"$j")
done

##### Maneira antiga de se obter a posição do jogo #####
#echo -n > posicao.txt
#posicao_pen=$(grep " $jogo" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10.txt \
#/home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30.txt \
#/home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45.txt /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50.txt \
#/home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais.txt | cut -d" " -f1 | cut -d":" -f2)

##### Maneira nova de se obter a posição do jogo #####
posicao_pen=$(./calc_posicao.sh $jogo[1] $jogo[2] $jogo[3] $jogo[4] $jogo[5] \
$jogo[6])

echo "Posição do jogo do penultimo concurso: $posicao_pen"

prox_concurso=$[$num_ult_concurso+1]
echo
echo "***** Apostas para o concurso Mega da Virada 2021/2022 *****"
#echo "== Apostas para o concurso Mega da Virada 2021/2022 ==" >> mega_virada.txt
#echo "Total $q jogos" >> mega_virada.txt
#echo "" >> mega_virada.txt

for k in $(seq 1 3) # Repetirá o processo por 3 vezes. Motivo: São três 
do		# diferentes grupos de números retirados ($R12)

#################### 12 DEZENAS SERÃO RETIRADAS DAS APOSTAS ####################
echo -n > nuns_shuf_R12.txt
echo -n > /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt

shuf -i 2-59 -n 12 > nuns_shuf_R12.txt
cont=1

############### montando um array com as dezenas retiradas #####################
while read linha 
	do
	R12[$cont]="$linha"
	cont=$[$cont+1]
done < nuns_shuf_R12.txt
echo
echo "Nº retirados: "$R12""
		
################## string para ser utilizado no egrep ##########################
string="'| $R12[1] | $R12[2] | $R12[3] | $R12[4] | $R12[5] | $R12[6] | \
$R12[7] | $R12[8] | $R12[9] | $R12[10] | $R12[11] | $R12[12] |'"


################################## DECIDEO FLUXO ###############################
echo "Aguarde..."
if [ "$posicao_pen" -lt "$posicao_ult" ] ########## MENORES QUE O ÚLTIMO #####
	then
	if [[ ($posicao_ult -gt 0) && ($posicao_ult -le 5000000) ]]
		then
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 5000000) && ($posicao_ult -le 10000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 10000000) && ($posicao_ult -le 15000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 15000000) && ($posicao_ult -le 20000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 20000000) && ($posicao_ult -le 25000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 25000000) && ($posicao_ult -le 30000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 30000000) && ($posicao_ult -le 35000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 35000000) && ($posicao_ult -le 40000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 40000000) && ($posicao_ult -le 45000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 45000000) && ($posicao_ult -le 50000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 50000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | \
		grep '\s[234]$' | egrep -v $string | \
		cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi

############################# MAIORES QUE O ÚLTIMO ################
else
	if [[ ($posicao_ult -gt 0) && ($posicao_ult -le 5000000) ]]
	
		then
		calc=$[5000000 - $posicao_ult]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 5000000) && ($posicao_ult -le 10000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 10000000) && ($posicao_ult -le 15000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 15000000) && ($posicao_ult -le 20000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 20000000) && ($posicao_ult -le 25000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 25000000) && ($posicao_ult -le 30000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000-$linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 30000000) && ($posicao_ult -le 35000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 35000000) && ($posicao_ult -le 40000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 40000000) && ($posicao_ult -le 45000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 45000000) && ($posicao_ult -le 50000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 50000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | \
		cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais_impar.txt | grep '\s[234]$' | \
		egrep -v $string | cut -d" " -f1-7 >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt
	fi

fi

############### contando linhas no arquivo /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt #######################
lin=$(cat /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt | wc -l) 
#echo "Quantidade de jogos possíveis: $lin"

############################## Sorteando os jogos ##############################
quant_apostas=$[$quant_apostas/3]
n=0
while [ $n -lt $quant_apostas ]
	do
	nx=$(shuf -i 1-$lin -n 1)
							
	jog=$(head -n$nx /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt | tail -n1)
	posi=$(head -n$nx /home/junior/Documentos/Meus_scripts/Loterias/megasena/filtrados.txt | tail -n1 | cut -d" " -f1)
	if [[ ($posi -ge 3710323) && ($posi -le 7410323) || \
	($posi -ge 40710323) && ($posi -le 44410323) || \
	($posi -ge 14810323) && ($posi -le 33310323) ]]
		then
		echo "$jog"
		echo "$jog" >> apostas_mega_virada.txt
		n=$[$n+1]
	fi
done
quant_apostas=$q # variavel quant_apostas volta a ter o valor inicial "q"
done
echo
echo "Suas $q apostas foram registradas no arquivo apostas_mega_virada.txt"
echo "######################### BOA SORTE! #########################"
