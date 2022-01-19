#!/bin/zsh
##################################################################################
## loterias.sh - Shell script para loterias Caixa								##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 03/12/2021													##
## Descrição:																	##
##		- script para escolher uma das loterias Caixa							##
##		Loterias disponíveis:													##
##			- Lotofácil															##
##			- Megasena															##
##			- Quina																##
## Requisitos:	- necessita do programa lynx instalado							##
## Exemplo de uso: ./loterias.sh												##
##################################################################################
clear

#dialog \
#--title "CAIXA" \
#--infobox "\n\n########## LOTERIAS CAIXA ###########\
#\n############ BEM VINDO ##############\
#\n\n   testando a conexão com o site" \
#10 43
#sleep 4
 

echo
echo
echo "################# LOTERIAS CAIXA ##################"
echo "#################### BEM VINDO ####################"
echo
echo

# teste de conexão com o site
ping -w1 www.mazusoft.com.br > /dev/null 2>&1
if [ $? -ne 0 ]
	then
	#dialog \
	#--title "CONEXÃO" \
	#--infobox "\nSem conexão com MAZUSOFT.COM.BR" \
	#5 35
	#sleep 4
	echo "Sem conexão com MAZUSOFT.COM.BR"
	exit 0
fi
########################### RESULTADOS RECENTES ################################

#### LOTOFACIL ####
end_site="https://www.mazusoft.com.br/lotofacil/resultado.php?"
scraping_loto=$(lynx -dump -nolist "${end_site}")
loto_concurso=$(echo "$scraping_loto" | grep "Resultado da Lotofácil ")
loto_dezenas=$(echo "$scraping_loto" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')
echo "$loto_concurso"
echo "$loto_dezenas"

cd /home/shell/Loterias/lotofacil
./se_compensa_jogar.sh

echo
atv=$(cd /home/shell/Loterias/lotofacil; \
tail -n1 concursos.txt)
echo "Última atividade:"
echo "$atv"
echo "--------------------------------------------------"
echo
#### MEGASENA ####
end_site="https://www.mazusoft.com.br/mega/resultado.php?"
scraping_mega=$(lynx -dump -nolist "${end_site}")
mega_concurso=$(echo "$scraping_mega" | grep "Resultado da MegaSena ")
mega_dezenas=$(echo "$scraping_mega" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')
echo "$mega_concurso"
echo "$mega_dezenas"
cd /home/shell/Loterias/megasena
./se_compensa_jogar.sh
echo
atv=$(cd /home/shell/Loterias/megasena; \
tail -n1 concursos.txt)
echo "Última atividade:"
echo "$atv"
echo "--------------------------------------------------"
echo
#### QUINA ####
end_site="https://www.mazusoft.com.br/quina/resultado.php?"
scraping_quina=$(lynx -dump -nolist "${end_site}")
quina_concurso=$(echo "$scraping_quina" | grep "Resultado da Quina ")
quina_dezenas=$(echo "$scraping_quina" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')
echo "$quina_concurso"
echo "$quina_dezenas"
cd /home/shell/Loterias/quina
./se_compensa_jogar.sh
echo
atv=$(cd /home/shell/Loterias/quina; \
tail -n1 concursos.txt)
echo "Última atividade:"
echo "$atv"
echo "--------------------------------------------------"
echo

echo "Escolha uma das opções abaixo"
echo
echo "Digite 1 para LOTOFÁCIL"
echo "Digite 2 para MEGASENA"
echo "Digite 3 para QUINA"
echo "Digite 4 para ENCERRAR"
echo
read acao

if [ $acao = 1 ]
	then
	echo "Voce escolheu LOTOFÁCIL"
	sleep 1
	cd /home/shell/Loterias/lotofacil
	./lotofacil.sh
	
elif [ $acao = 2 ]
	then
	echo "Voce escolheu MEGASENA"
	sleep 1
	cd /home/shell/Loterias/megasena
	./megasena.sh

elif [ $acao = 3 ]
	then
	echo "Voce escolheu QUINA"
	sleep 1
	cd /home/shell/Loterias/quina
	./quina.sh
	
elif [ $acao = 4 ]
	then
	echo "Voce escolheu ENCERRAR! Até a próxima."
	exit 0

else 
	echo "Opção invalida. Digite apenas 1,2,3 ou 4"
	exit 0
fi