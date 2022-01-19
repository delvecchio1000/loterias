#!/bin/zsh
##################################################################################
## apostar.sh - Script para loteria Lotofácil									##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 08/11/2021													##
## Este arquivo será chamado caso a opção 1 do arquivo lotofacil for escolhida  ##
## Descrição:																	##
##		Caso APOSTAR:															##
##		- Não precisa saber o nº do último concurso para apostar				##
##		o sistema vai informar para o usuário									##
##		- descobre a posição do penúltimo concurso da Lotofácil,				##
##		- descobre a posição do último concurso da Lotofácil,					##
##		- decide se as próximas apostas serão maiores ou menores				##
##		que o último concurso,													##
##		- Mostra a quantidade de apostas possíveis								##
##		- Filtra 7,8,9 quantidade de ímpares									##
##		- Aplica a técnica R5													##
## Exemplo de uso: ./lotofacil.sh												##
## Modificações: - 07/01/2022: Alterado o range da retirada de números			## 
## 		aleatórios para 1-25, apenas para fins de teste dos resultados			##
##################################################################################

echo -n > nuns_shuf_R5.txt
echo -n > /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/filtrados.txt

######################### DADOS DO ÚLTIMO CONCURSO #############################
end_site="https://www.mazusoft.com.br/lotofacil/resultado.php?"
scraping=$(lynx -dump -nolist "${end_site}")

dezenas_ult_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

num_ult_concurso=$(echo "$scraping" | grep "Resultado da Lotofácil " | \
cut -d" " -f4)

echo
echo "Dezenas do último concurso:"
echo "$dezenas_ult_concurso"
                       	
# formando um array com o jogo gravado no arquivo dados.txt                  			
for x in $(seq 1 15)
	do
	ult[$x]=$(echo $dezenas_ult_concurso | cut -d" " -f$x)
done

ultconcurso=$num_ult_concurso
penconcurso=$[$ultconcurso-1]
concurso=$[$ultconcurso+1]
echo
echo "O número do concurso que você irá apostar é: $concurso"
echo

####################### INICIO DADOS DO PENÚLTIMO CONCURSO #####################
num_pen_concurso=$[$num_ult_concurso-1]
scraping=$(lynx -dump -nolist "${end_site}concurso=$num_pen_concurso")

dezenas_pen_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

echo "Dezenas do penúltimo concurso ("$num_pen_concurso"):"
echo "$dezenas_pen_concurso"

for x in $(seq 1 15)
	do
	pen[$x]=$(echo $dezenas_pen_concurso | cut -d" " -f$x)
done

echo

posicaopen=$(grep -m1 " $pen " /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/loto_base.txt | cut -d" " -f1)
posicaoult=$(grep -m1 " $ult " /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/loto_base.txt | cut -d" " -f1)
		
################################## DECIDEO FLUXO ##############################
#Se o penultimo for menor que o último: serão utilizados jogos
#menores que o último
#Se o penultimo for maior que o último: serão utilizados jogos
#maiores que o último

for r in $(seq 1 3)
	do
	#Escolhe 5 números não repetidos no intervalo de 2 a 24


#	shuf -i 2-24 -n 5 > nuns_shuf_R5.txt

#	Alterado o range para 1-25, apenas para fins de teste dos resultados
#	data desta alteração 07/01/2022
	shuf -i 1-25 -n 5 > nuns_shuf_R5.txt
	cont=1
	# montando um array com as dezenas retiradas
	while read linha
		do
		R5[$cont]=$linha
		let cont=$cont+1
	done < nuns_shuf_R5.txt
		
	#string para ser utilizado no egrep
	string="'| $R5[1] | $R5[2] | $R5[3] | $R5[4] | $R5[5] |'"
		
	########################### MENORES ####################################
	if [ $posicaopen -lt $posicaoult ]
		then
		head -n$posicaoult /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/loto_base.txt | grep '\s[789]$' | \
		egrep -v $string | cut -d" " -f2-16 >> /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/filtrados.txt

	############################# MAIORES ##################################
	else
		calc=$[3268760 - $posicaoult]
		tail -n$calc /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/loto_base.txt | grep '\s[789]$' | egrep -v \
		$string | cut -d" " -f2-16 >> /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/filtrados.txt
	fi
done

#contando linhas no arquivo
lin=$(cat /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/filtrados.txt | wc -l)
echo "Jogos disponíveis para aposta: $lin"
echo
		
################# Preenchimento do arquivo log_jogos.txt #######################
printf "Insira a quantidade que deseja apostar: "
read quant_apostas
		
echo
echo "***** Apostas para o concurso $concurso *****"
echo "**** Apostas para o concurso $concurso da Lotofácil ****" >> log_jogos.txt
echo "Total $quant_apostas jogos" >> log_jogos.txt
echo "" >> log_jogos.txt
echo
		
# sorteia um número do intervalo de linhas do arquivo /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/filtrados.txt. Acessa a 
# linha sorteada e lê as dezenas. Imprime as dezenas em log_jogos.txt
for q in $(seq $quant_apostas)
	do
	nx=$(shuf -i 1-$lin -n 1)			
	jog=$(head -n$nx /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/filtrados.txt | tail -n1)
	echo "$jog"							
	echo "$jog" >> log_jogos.txt
done

echo
echo "Suas $quant_apostas apostas foram registradas no arquivo log_jogos.txt"
echo "######################### BOA SORTE! #########################"
echo "===================================================" >> log_jogos.txt
# Grava no arquivo concursos.txt o número do concurso para o qual as apostas
# foram feitas
echo "$concurso" >> concursos.txt
echo
echo "Escolha uma das opções abaixo"
echo

echo "Digite 1 para MEGASENA"
echo "Digite 2 para QUINA"
echo "Digite 3 para ENCERRAR"
echo
read acao

if [ $acao = 1 ]
	then
	echo "Voce escolheu MEGASENA"
	sleep 1
	cd /home/junior/Documentos/Meus_scripts/Loterias/megasena
	./megasena.sh

elif [ $acao = 2 ]
	then
	echo "Voce escolheu QUINA"
	sleep 1
	cd /home/junior/Documentos/Meus_scripts/Loterias/quina
	./quina.sh
	
elif [ $acao = 3 ]
	then
	echo "Voce escolheu ENCERRAR! Até a próxima."
	exit 0

else 
	echo "Opção invalida. Digite apenas 1,2 ou 3"
	exit 0
fi