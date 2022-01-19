#!/bin/zsh
##################################################################################
## quina.sh - Script para loteria Quina											##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 01/12/2021													##
## Descrição:																	##
##		- Captura as dezenas do último concurso									##
##		- Captura o número do último concurso									##
##		- Descobre a posição do jogo do último concurso							##
##		- Captura as dezenas do penúltimo concurso								##
##		- Captura o número do penúltimo concurso								##
##		- Descobre a posição do jogo do penúltimo concurso						##
##		- Utiliza a técnica R16 (retira 16 números do universo)					##
##		- Monta o arquivo /home/junior/Documentos/Meus_scripts/Loterias/quina/	##
##			filtrados.txt contendo os jogos filtrados							##
##		- Filtros utilizados: 					 								##
##			- R16																##
##			- quant de ímpares (só jogos com 2 ou 3 ímpares)					##
##			- variação do fluxo de jogo (entre penultimo e ult)					##
##			- jogos entre 1.401.533 e 2.801.533, ou								##
##			- jogos entre 4.201.533 e 8.401.533, ou								##
##			- jogos entre 9.801.533 e 18.201.533, ou							##
##			- jogos entre 21.001.533 e 23.801.533								##
##		- Guarda os jogos no arquivo log_jogos.txt								##
## Requisitos:																	##
##		- Necessita do programa lynx instalado na máquina						##
## Exemplo de uso: ./megasena.sh												##
## Modificações: - 07/01/2022: Alterado o range da retirada de números			## 
## 		aleatórios para 1-80, apenas para fins de teste dos resultados			##
##		(linha 138)																##
##################################################################################

printf "Digite a quantidade de jogos ( MÚLTIPLO DE 3! ): "
read q

quant_apostas=$q
####################### INICIO DADOS DO ÚLTIMO CONCURSO ########################
end_site="https://www.mazusoft.com.br/quina/resultado.php?"
scraping=$(lynx -dump -nolist "${end_site}")

dezenas_ult_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

num_ult_concurso=$(echo "$scraping" | grep "Resultado da Quina " | \
cut -d" " -f4)

echo "Número do último concurso: "$num_ult_concurso""
echo "Dezenas do último concurso: "$dezenas_ult_concurso""

############### Buscando a posição do jogo do último concurso ##################
#echo -n > posicao.txt
for j in $(seq 1 5)
	do
	jogo[$j]=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
	tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | \
	sed 's/03/3/g' | sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | \
	sed 's/07/7/g' | sed 's/08/8/g' | sed 's/09/9/g' | cut -d" " -f"$j")
done

posicao_ult=$(grep " $jogo" /home/junior/Documentos/Meus_scripts/Loterias/\
quina/quina_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_5_10.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_10_15.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_15_20.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_20_mais.txt | cut -d" " -f1 | cut -d":" -f2)
echo "Posição do jogo do último concurso: $posicao_ult"

#for x in /home/junior/Documentos/Meus_scripts/Loterias/quina/\
#quina_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_5_10.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_10_15.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_15_20.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_20_mais.txt
#	do
#	posicao_ult=$(grep -m1 " $jogo" "$x" | cut -d" " -f1)
#	if [ "$posicao_ult" > 0 ]
#		then
#		echo "Posição do jogo do último concurso: "$posicao_ult""
#		echo "$posicao_ult" > posicao.txt # Esta variavel está se 
#		# apagando ao sair deste laço for. Portanto tive que 
#		# salvá-la em um arquivo externo.
#	fi
#done
#posicao_ult=$(cat posicao.txt) # Aqui recupero a variavel novamente

##################### TÉRMINO DADOS DO ÚLTIMO CONCURSO #########################

####################### INICIO DADOS DO PENÚLTIMO CONCURSO #####################
num_pen_concurso=$[$num_ult_concurso-1]
scraping=$(lynx -dump -nolist "${end_site}concurso=$num_pen_concurso")

dezenas_pen_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')


echo
echo "Número do penúltimo concurso: "$num_pen_concurso""
echo "Dezenas do penúltimo concurso: "$dezenas_pen_concurso""

############## Buscando a posição do jogo do penúltimo concurso ################
#echo -n > posicao.txt
for j in $(seq 1 5)
	do
	jogo[$j]=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
	tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | \
	sed 's/03/3/g' | sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | \
	sed 's/07/7/g' | sed 's/08/8/g' | sed 's/09/9/g' | cut -d" " -f"$j")
done

posicao_pen=$(grep " $jogo" /home/junior/Documentos/Meus_scripts/Loterias/\
quina/quina_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_5_10.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_10_15.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_15_20.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_20_mais.txt | cut -d" " -f1 | cut -d":" -f2)
echo "Posição do jogo do penultimo concurso: $posicao_pen"


#for x in /home/junior/Documentos/Meus_scripts/Loterias/quina/\
#quina_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_5_10.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_10_15.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_15_20.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_20_mais.txt
#	do
#	posicao_pen=$(grep -m1 " $jogo" "$x" | cut -d" " -f1)
#	if [ "$posicao_pen" > 0 ]
#		then
#		echo "Posição do jogo do penúltimo concurso: "$posicao_pen""
#		echo "$posicao_pen" > posicao.txt # Esta variavel estava se 
#		# apagando ao sair deste laço for. Portanto tive que 
#		# salvá-la em um arquivo externo.	
#	fi
#done
#posicao_pen=$(cat posicao.txt) # Aqui recupero a variavel novamente

prox_concurso=$[$num_ult_concurso+1]
echo
echo "***** Apostas para o concurso $prox_concurso *****"
echo "**** Apostas para o concurso $prox_concurso da Quina ****" >> log_jogos.txt
echo "Total $q jogos" >> log_jogos.txt
echo "" >> log_jogos.txt

for k in $(seq 1 3) # Repetirá o processo por 3 vezes. Motivo: São três 
do		# diferentes grupos de números retirados ($R16)

#################### 16 DEZENAS SERÃO RETIRADAS DAS APOSTAS ####################
echo -n > nuns_shuf_R16.txt
echo -n > /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt

#shuf -i 2-79 -n 16 > nuns_shuf_R16.txt

#	Alterado o range para 1-80, apenas para fins de teste dos resultados
#	data desta alteração 07/01/2022
shuf -i 1-80 -n 16 > nuns_shuf_R16.txt


cont=1

############### montando um array com as dezenas retiradas #####################
while read linha 
	do
	R16[$cont]="$linha"
	cont=$[$cont+1]
done < nuns_shuf_R16.txt
echo
echo "Nº retirados: "$R16""
		
################## string para ser utilizado no egrep ##########################
string="'| $R16[1] | $R16[2] | $R16[3] | $R16[4] | $R16[5] | $R16[6] | \
$R16[7] | $R16[8] | $R16[9] | $R16[10] | $R16[11] | $R16[12] | $R16[13] |\
 $R16[14] | $R16[15] | $R16[16] |'"


################################## DECIDEO FLUXO ###############################
echo "Aguarde..."
if [ "$posicao_pen" -lt "$posicao_ult" ] ########## MENORES QUE O ÚLTIMO #####
	then
	if [[ ($posicao_ult -gt 0) && ($posicao_ult -le 5000000) ]]
		then
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/quina/\
		quina_0_5_impar.txt | grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 \
		>> /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 5000000) && ($posicao_ult -le 10000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/quina/\
		quina_5_10_impar.txt | grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 \
		>> /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 10000000) && ($posicao_ult -le 15000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_5_10_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/quina/\
		quina_10_15_impar.txt | grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 \
		>> /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 15000000) && ($posicao_ult -le 20000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_5_10_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_10_15_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/quina/\
		quina_15_20_impar.txt | grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 \
		>> /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 20000000) ]]
		then
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_5_10_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_10_15_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_15_20_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		head -n$posicao_ult /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_20_mais_impar.txt | grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 \
		>> /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi

############################# MAIORES QUE O ÚLTIMO ################
else
	if [[ ($posicao_ult -gt 0) && ($posicao_ult -le 5000000) ]]
	
		then
		calc=$[5000000 - $posicao_ult]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_5_10_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_10_15_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_15_20_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_20_mais_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 5000000) && ($posicao_ult -le 10000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_5_10_impar.txt | cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/quina/\
		quina_5_10_impar.txt | grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 \
		>> /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_10_15_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_15_20_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_20_mais_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 10000000) && ($posicao_ult -le 15000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/quina/\
		quina_10_15_impar.txt | cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_10_15_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_15_20_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_20_mais_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 15000000) && ($posicao_ult -le 20000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_15_20_impar.txt | cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_15_20_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
		cat /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_20_mais_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
		
	if [[ ($posicao_ult -gt 20000000) ]]
		then
		linha=$(grep -n "$posicao_ult" /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_20_mais_impar.txt | cut -d":" -f1)
		calc=$[5000000 - $linha]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_20_mais_impar.txt \
		| grep '\s[23]$' | egrep -v $string | cut -d" " -f1-6 >> /home/junior/\
		Documentos/Meus_scripts/Loterias/quina/filtrados.txt
	fi
fi

############### contando linhas no arquivo filtrados.txt #######################
lin=$(cat /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt | wc -l) 
#echo "Quantidade de jogos possíveis: $lin"
############################## Sorteando os jogos ##############################
quant_apostas=$[$quant_apostas/3]
n=0
while [ $n -lt $quant_apostas ]
	do
	nx=$(shuf -i 1-$lin -n 1)
							
	jog=$(head -n$nx /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt \
	| tail -n1)
	posi=$(head -n$nx /home/junior/Documentos/Meus_scripts/Loterias/quina/filtrados.txt \
	| tail -n1 | cut -d" " -f1)
	if [[ ($posi -ge 1401533) && ($posi -le 2801533) || \
	($posi -ge 4201533) && ($posi -le 8401533) || \
	($posi -ge 9801533) && ($posi -le 18201533) || \
	($posi -ge 21001533) && ($posi -le 23801533) ]]
		then
		n=$[$n+1]
		echo "$jog"
		echo "$jog" >> log_jogos.txt
		
	fi
done
quant_apostas=$q # variavel quant_apostas volta a ter o valor inicial "q"
done
echo
echo "Suas $quant_apostas apostas foram registradas no arquivo log_jogos.txt"
echo "######################### BOA SORTE! #########################"
echo "=======================================================" >> log_jogos.txt
echo "" >> log_jogos.txt

# Grava no arquivo concursos.txt o número do concurso para o qual as apostas
# foram feitas
echo "$prox_concurso" >> concursos.txt
echo
echo "Escolha uma das opções abaixo"
echo
echo "Digite 1 para LOTOFÁCIL"
echo "Digite 2 para MEGASENA"
echo "Digite 3 para ENCERRAR"
echo
read acao

if [ $acao = 1 ]
	then
	echo "Voce escolheu LOTOFÁCIL"
	sleep 1
	cd /home/junior/Documentos/Meus_scripts/Loterias/lotofacil
	./lotofacil.sh
	
elif [ $acao = 2 ]
	then
	echo "Voce escolheu MEGASENA"
	sleep 1
	cd /home/junior/Documentos/Meus_scripts/Loterias/megasena
	./megasena.sh

elif [ $acao = 3 ]
	then
	echo "Voce escolheu ENCERRAR! Até a próxima."
	exit 0

else 
	echo "Opção invalida. Digite apenas 1,2 ou 3"
	exit 0
fi