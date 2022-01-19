#!/bin/zsh
##########################################################################
## conferir.sh - Shell script para loteria Lotofácil					##
## Autor: Benedito Del Vecchio Junior                                   ##
## Data de criação: 09/11/2021                                          ##
## Descrição:                                                           ##
##            - totaliza a quantidade de acertos em cada aposta         ##
##            - indica apostas premiadas                                ##
## Exemplo de uso: ./conferir.sh										##
##########################################################################

echo
# lista os concursos que contém apostas
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

concurso=$(cat log_jogos.txt | grep "**** Apostas para o concurso $n" | \
cut -d" " -f6)

# Caso queira debugar
#echo "Número do concurso:"
#echo "$concurso"
#exit 0

if [ -s $concurso ]
	then
	echo "Não foram feitas apostas para o concurso $n!"
	echo
	exit 0
fi


# Captura de dados do site
end_site="https://www.mazusoft.com.br/lotofacil/resultado.php?concurso=$n"
scraping=$(lynx -dump -nolist "${end_site}")

# Caso queira debugar
#echo "$scraping"
#exit 0

# Separando as dezenas
dezenas_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

# Caso queira debugar
#echo "Dezenas do concurso:"
#echo "$dezenas_concurso"
#exit 0

if [ $dezenas_concurso = "? ? ? ? ? ? ? ? ? ? ? ? ? ? ?" ]
	then
	echo "Rateio em processamento ou concurso não realizado"
	exit 0
fi

# Formando um array com as dezenas
for x in $(seq 1 15)
	do
	ult[$x]=$(echo $dezenas_concurso | cut -d" " -f$x)
done

# Caso queira debugar
#echo "Array com as dezenas:"
#echo "$ult"
#exit 0

onze=0;
doze=0;
treze=0;
quatorze=0;
quinze=0;
cont=0

echo

lin=$(cat /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/filtrados.txt | wc -l)

# Caso queira debugar
#echo "Número de linhas do arquivo /home/junior/Documentos/Meus_scripts/Loterias/lotofacil/filtrados.txt:"
#echo "$lin"
#exit 0

echo " " >> log_jogos.txt
echo "******************* RESULTADO *******************" >> log_jogos.txt
data=$(date +"%d/%m/%Y às %T")

echo "Conferência do concurso $concurso em $data" >> log_jogos.txt

echo "Dezenas sorteadas $ult" >> log_jogos.txt
echo " " >> log_jogos.txt

quant_apostas=$(cat log_jogos.txt | \
grep -A 1 "**** Apostas para o concurso $concurso" | tail -n1 | cut -d" " -f2 )

# Caso queira debugar
#echo "Quantidade de apostas:"
#echo "$quant_apostas"
#exit 0

let c=$quant_apostas+2

# Caso queira debugar
#echo "Variável \$c:"
#echo "$c"
#exit 0

onze=0;
doze=0;
treze=0;
quatorze=0;
quinze=0;
cont2=0

# será lido cada linha do arquivo "log_jogos.txt" e processará a quantidade de 
# dezenas certas em cada jogo
for a in $(seq 1 $quant_apostas)
	do
	#ajuste=$[$a+1]
	
	b1=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f1)
	
	# Caso queira debugar
	#echo "Variável \$b1:"
	#echo "$b1"
	#exit 0
	
	b2=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f2)
	
	# Caso queira debugar
	#echo "Variável \$b2:"
	#echo "$b2"
	#exit 0
	
	b3=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f3)
	b4=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f4)
	b5=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f5)
	b6=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f6)
	b7=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f7)
	b8=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f8)
	b9=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f9)
	b10=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f10)
	b11=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f11)
	b12=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f12)
	b13=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f13)
	b14=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f14)
	b15=$(grep -A $c "**** Apostas para o concurso $concurso" log_jogos.txt \
	| head -n$[$a+3] | tail -n1 | cut -d" " -f15)
	
	j1=($b1 $b2 $b3 $b4 $b5 $b6 $b7 $b8 $b9 $b10 $b11 $b12 $b13 $b14 $b15)
	
	# Caso queira debugar
	#echo "Variável \$j1:"
	#echo "$j1"
	#exit 0
	
	for d in $(seq 1 $quant_apostas)
	do
		if [[ ($j1[$d] -eq $ult[1]) || \
		($j1[$d] -eq $ult[2]) || \
		($j1[$d] -eq $ult[3]) || \
		($j1[$d] -eq $ult[4]) || \
		($j1[$d] -eq $ult[5]) || \
		($j1[$d] -eq $ult[6]) || \
		($j1[$d] -eq $ult[7]) || \
		($j1[$d] -eq $ult[8]) || \
		($j1[$d] -eq $ult[9]) || \
		($j1[$d] -eq $ult[10]) || \
		($j1[$d] -eq $ult[11]) || \
		($j1[$d] -eq $ult[12]) || \
		($j1[$d] -eq $ult[13]) || \
		($j1[$d] -eq $ult[14]) || \
		($j1[$d] -eq $ult[15]) ]]
			then
			cont2=$[$cont2+1]
		fi
	done
	
	if [ $cont2 -eq 11 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_11)" >> log_jogos.txt
		  onze=$[$onze+1]
	elif [ $cont2 -eq 12 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_12)" >> log_jogos.txt
		  doze=$[$doze+1]
	elif [ $cont2 -eq 13 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_13)" >> log_jogos.txt
		  treze=$[$treze+1]
	elif [ $cont2 -eq 14 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_14)" >> log_jogos.txt
		  quatorze=$[$quatorze+1]
	elif [ $cont2 -eq 15 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_15)" >> log_jogos.txt
		  quinze=$[$quinze+1]
	else
		  echo "${j1} ==> $cont2 acertos"
	fi
	cont2=0
done
echo
echo "11 acertos: $onze"
echo "12 acertos: $doze"
echo "13 acertos: $treze"
echo "14 acertos: $quatorze"
echo "15 acertos: $quinze"
echo "Total de jogos: $quant_apostas"

echo " " >> log_jogos.txt
echo "11 acertos: $onze" >> log_jogos.txt
echo "12 acertos: $doze" >> log_jogos.txt
echo "13 acertos: $treze" >> log_jogos.txt
echo "14 acertos: $quatorze" >> log_jogos.txt
echo "15 acertos: $quinze" >> log_jogos.txt

echo "==================================================" >> log_jogos.txt

# Altera para "conferido" o número do concurso no arquivo concursos.txt 
sed -i "s/"$n"/"$n" conferido/" concursos.txt
echo
echo "Deseja conferir outra loteria?"
echo "... então"
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