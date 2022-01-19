#!/bin/zsh
##########################################################################
## conferir.sh - Shell script para loteria megasena			##
## Autor: Benedito Del Vecchio Junior                                   ##
## Data de criação: 01/12/2021                                          ##
## Descrição:                                                           ##
##            - totaliza a quantidade de acertos em cada aposta         ##
##            - indica apostas premiadas                                ##
## Requisitos:								##
##		- Necessita do programa lynx instalado na máquina	##
## Exemplo de uso: ./conferir.sh					##
##########################################################################

echo
echo "Últimos concursos:"
while read linha
	do
	echo "$linha"
done < concursos.txt

echo
printf "Deseja prosseguir [s/n] ";read resposta
echo
case $resposta in
	s)
		echo "Voce escolheu continuar"
		echo ;;
	n)
		echo "Operacao interrompida"
		exit 0;;
	*)
		echo "Opção invalida. Digite apenas s ou n"
		exit 0;;
esac

printf "Insira o número do concurso que deseja conferir: "
read n

concurso=$(cat log_jogos.txt | grep "== Apostas para o concurso $n" | \
cut -d" " -f6)

if [ -s $concurso ]
	then
	echo "Não foram feitas apostas para o concurso $n!"
	exit 0
fi

echo

# teste de conexão com o site
ping -w1 www.mazusoft.com.br > /dev/null 2>&1
if [ $? -ne 0 ]
	then
	echo "Sem conexão com MAZUSOFT.COM.BR"
	exit 0
fi

# Captura de dados do site
end_site="https://www.mazusoft.com.br/mega/resultado.php?concurso=$n"
scraping=$(lynx -dump -nolist "${end_site}")

# Separando as dezenas
dezenas_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

# Formando um array com as dezenas
for x in $(seq 1 6)
	do
	ult[$x]=$(echo $dezenas_concurso | cut -d" " -f$x)
done

echo "******************* RESULTADO ******************" >> log_jogos.txt
data=$(date +"%d/%m/%Y às %T")
echo "Conferência do concurso $concurso em $data" >> log_jogos.txt
echo "Dezenas sorteadas $ult" >> log_jogos.txt
echo "" >> log_jogos.txt

# descobrindo a quantidade de apostas que foram feitas
quant_apostas=$(cat log_jogos.txt | \
grep -A 1 "== Apostas para o concurso $concurso" | tail -n1 | cut -d" " -f2 )

let c=$quant_apostas+2

quatro=0;
cinco=0;
seis=0;
cont2=0

# Conferência de dezenas
for a in $(seq 1 $quant_apostas) 
	do                       
	
	b1=$(grep -A $c "== Apostas para o concurso $concurso" log_jogos.txt | \
	tail -n$a | head -n1 | cut -d" " -f2)
	b2=$(grep -A $c "== Apostas para o concurso $concurso" log_jogos.txt | \
	tail -n$a | head -n1 | cut -d" " -f3)
	b3=$(grep -A $c "== Apostas para o concurso $concurso" log_jogos.txt | \
	tail -n$a | head -n1 | cut -d" " -f4)
	b4=$(grep -A $c "== Apostas para o concurso $concurso" log_jogos.txt | \
	tail -n$a | head -n1 | cut -d" " -f5)
	b5=$(grep -A $c "== Apostas para o concurso $concurso" log_jogos.txt | \
	tail -n$a | head -n1 | cut -d" " -f6)
	b6=$(grep -A $c "== Apostas para o concurso $concurso" log_jogos.txt | \
	tail -n$a | head -n1 | cut -d" " -f7)
	
	j1=($b1 $b2 $b3 $b4 $b5 $b6)
	
	for d in $(seq 1 6)
		do
		if [[ ($j1[$d] -eq $ult[1]) || \
		($j1[$d] -eq $ult[2]) || \
		($j1[$d] -eq $ult[3]) || \
		($j1[$d] -eq $ult[4]) || \
		($j1[$d] -eq $ult[5]) || \
		($j1[$d] -eq $ult[6]) ]]
			then
			cont2=$[$cont2+1]
		fi
	done
	
	if [ $cont2 -eq 4 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_4)" >> log_jogos.txt
		  quatro=$[$quatro+1]
	elif [ $cont2 -eq 5 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_5)" >> log_jogos.txt
		  cinco=$[$cinco+1]
	elif [ $cont2 -eq 6 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_6)" >> log_jogos.txt
		  seis=$[$seis+1]
	else
		  echo "${j1} ==> $cont2 acertos"
		  echo "${j1} ==> $cont2 acertos" >> log_jogos.txt
	fi
	cont2=0
done
echo "4 acertos: $quatro"
echo "5 acertos: $cinco"
echo "6 acertos: $seis"
echo " " >> log_jogos.txt
echo "4 acertos: $quatro" >> log_jogos.txt
echo "5 acertos: $cinco" >> log_jogos.txt
echo "6 acertos: $seis" >> log_jogos.txt
echo "==================================================" >> log_jogos.txt
data=$(date +"%d/%m/%Y")
# Altera para "conferido" o número do concurso no arquivo concursos.txt 
sed -i "s/"$n"/"$n" conferido/" concursos.txt
echo
echo "Deseja conferir outra loteria?"
echo "... então"
echo "Digite 1 para LOTOFÁCIL"
echo "Digite 2 para QUINA"
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