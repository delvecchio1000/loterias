#!/bin/zsh
##########################################################################
## confere_mega_da_virada.sh - Shell script para loteria megasena	##
## Autor: Benedito Del Vecchio Junior                                   ##
## Data de criação: 24/12/2021                                          ##
## Descrição:                                                           ##
##            - totaliza a quantidade de acertos em cada aposta         ##
##            - indica apostas premiadas                                ##
## Requisitos:								##
##		- Necessita do programa lynx instalado na máquina	##
## Modificações: - 01/01/2022: Incluido a conferência aproximada de	##
##		dezenas							##
## Exemplo de uso: ./confere_mega_da_virada.sh				##
##########################################################################

clear
echo

# teste de conexão com o site
ping -w1 www.mazusoft.com.br > /dev/null 2>&1
if [ $? -ne 0 ]
	then
	echo "Sem conexão com MAZUSOFT.COM.BR"
	exit 0
fi

# Captura de dados do site

echo "Digite o número do concurso"
echo
read acao

n=$acao #número do concurso
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

zero=0; um=0; dois=0; tres=0; quatro=0; cinco=0; seis=0; cont2=0

echo "Conferência exata de dezenas\nConcurso: $n" >> resultado_mega_virada.txt

echo "Conferência exata de dezenas\nConcurso: $n"
echo " " >> resultado_mega_virada.txt
echo
while read linha
	do                       
	
	b1=$(echo $linha | cut -d" " -f2)
	b2=$(echo $linha | cut -d" " -f3)
	b3=$(echo $linha | cut -d" " -f4)
	b4=$(echo $linha | cut -d" " -f5)
	b5=$(echo $linha | cut -d" " -f6)
	b6=$(echo $linha | cut -d" " -f7)
	
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
		  echo "${j1} ==> (PREMIADA_4)" >> resultado_mega_virada.txt
		  quatro=$[$quatro+1]
	elif [ $cont2 -eq 5 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_5)" >> resultado_mega_virada.txt
		  cinco=$[$cinco+1]
	elif [ $cont2 -eq 6 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_6)" >> resultado_mega_virada.txt
		  seis=$[$seis+1]
	else
		  echo "${j1} ==> $cont2 acertos"
		  echo "${j1} ==> $cont2 acertos" >> resultado_mega_virada.txt
	fi
	cont2=0
done < apostas_mega_virada.txt
echo 
echo "4 acertos: $quatro"
echo "5 acertos: $cinco"
echo "6 acertos: $seis"
echo " " >> resultado_mega_virada.txt
echo "4 acertos: $quatro" >> resultado_mega_virada.txt
echo "5 acertos: $cinco" >> resultado_mega_virada.txt
echo "6 acertos: $seis" >> resultado_mega_virada.txt
echo

# Aqui será feito uma conferência daqueles jogos que passaram raspando. Será
# considerada dezena certa aquela que for maior uma unidade ou menor uma 
# unidade da dezena sorteada.
echo "Conferência aproximada de dezenas:"
echo " " >> resultado_mega_virada.txt
echo "Conferência aproximada de dezenas:" >> resultado_mega_virada.txt
echo " " >> resultado_mega_virada.txt
echo

zero=0; um=0; dois=0; tres=0; quatro=0; cinco=0; seis=0; cont2=0
acima1=0; abaixo1=0; acima1_acumulado=0; abaixo1_acumulado=0
acima2=0; abaixo2=0; acima2_acumulado=0; abaixo2_acumulado=0

while read linha
	do                       
	
	b1=$(echo $linha | cut -d" " -f2)
	b2=$(echo $linha | cut -d" " -f3)
	b3=$(echo $linha | cut -d" " -f4)
	b4=$(echo $linha | cut -d" " -f5)
	b5=$(echo $linha | cut -d" " -f6)
	b6=$(echo $linha | cut -d" " -f7)
	
	j1=($b1 $b2 $b3 $b4 $b5 $b6)
	
	
	
	for d in $(seq 1 6)
		do
		
		if [[ ($j1[$d] -eq $ult[1]) || \
		($j1[$d] -eq ($ult[1] + 1)) || \
		($j1[$d] -eq ($ult[1] - 1)) || \
		($j1[$d] -eq $ult[2]) || \
		($j1[$d] -eq ($ult[2] + 1)) || \
		($j1[$d] -eq ($ult[2] - 1)) || \
		($j1[$d] -eq $ult[3]) || \
		($j1[$d] -eq ($ult[3] + 1)) || \
		($j1[$d] -eq ($ult[3] - 1)) || \
		($j1[$d] -eq $ult[4]) || \
		($j1[$d] -eq ($ult[4] + 1)) || \
		($j1[$d] -eq ($ult[4] - 1)) || \
		($j1[$d] -eq $ult[5]) || \
		($j1[$d] -eq ($ult[5] + 1)) || \
		($j1[$d] -eq ($ult[5] - 1)) || \
		($j1[$d] -eq $ult[6]) || \
		($j1[$d] -eq ($ult[6] + 1)) || \
		($j1[$d] -eq ($ult[6] - 1)) ]]
			then
			cont2=$[$cont2+1]
		fi
		
		if [[ ($j1[$d] -eq ($ult[1] + 1)) || \
		($j1[$d] -eq ($ult[2] + 1)) || \
		($j1[$d] -eq ($ult[3] + 1)) || \
		($j1[$d] -eq ($ult[4] + 1)) || \
		($j1[$d] -eq ($ult[5] + 1)) || \
		($j1[$d] -eq ($ult[6] + 1)) ]]
			then
			acima1=$[$acima1+1]
			acima1_acumulado=$[$acima1_acumulado+1]
		fi
		
		if [[ ($j1[$d] -eq ($ult[1] - 1)) || \
		($j1[$d] -eq ($ult[2] - 1)) || \
		($j1[$d] -eq ($ult[3] - 1)) || \
		($j1[$d] -eq ($ult[4] - 1)) || \
		($j1[$d] -eq ($ult[5] - 1)) || \
		($j1[$d] -eq ($ult[6] - 1)) ]]
			then
			abaixo1=$[$abaixo1+1]
			abaixo1_acumulado=$[$abaixo1_acumulado+1]
		fi
		
				
		if [[ ($j1[$d] -eq ($ult[1] + 2)) || \
		($j1[$d] -eq ($ult[2] + 2)) || \
		($j1[$d] -eq ($ult[3] + 2)) || \
		($j1[$d] -eq ($ult[4] + 2)) || \
		($j1[$d] -eq ($ult[5] + 2)) || \
		($j1[$d] -eq ($ult[6] + 2)) ]]
			then
			acima2=$[$acima2+1]
			acima2_acumulado=$[$acima2_acumulado+1]
		fi
		
		if [[ ($j1[$d] -eq ($ult[1] - 2)) || \
		($j1[$d] -eq ($ult[2] - 2)) || \
		($j1[$d] -eq ($ult[3] - 2)) || \
		($j1[$d] -eq ($ult[4] - 2)) || \
		($j1[$d] -eq ($ult[5] - 2)) || \
		($j1[$d] -eq ($ult[6] - 2)) ]]
			then
			abaixo2=$[$abaixo2+1]
			abaixo2_acumulado=$[$abaixo2_acumulado+1]
		fi
		
	done
	
	
	if [ $cont2 -eq 1 ]
		then	
		  echo "${j1} ==> $cont2 acertos"
		  echo "${j1} ==> $cont2 acertos" >> resultado_mega_virada.txt
		  um=$[$um+1]
	elif [ $cont2 -eq 2 ]
		then	
		  echo "${j1} ==> $cont2 acertos"
		  echo "${j1} ==> $cont2 acertos" >> resultado_mega_virada.txt
		  dois=$[$dois+1]
	elif [ $cont2 -eq 3 ]
		then	
		  echo "${j1} ==> $cont2 acertos"
		  echo "${j1} ==> $cont2 acertos" >> resultado_mega_virada.txt
		  tres=$[$tres+1]
	elif [ $cont2 -eq 4 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_4)" >> resultado_mega_virada.txt
		  quatro=$[$quatro+1]
	elif [ $cont2 -eq 5 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_5)" >> resultado_mega_virada.txt
		  cinco=$[$cinco+1]
	elif [ $cont2 -eq 6 ]
		then	
		  echo "${j1} ==> $cont2 acertos (PREMIADA)"
		  echo "${j1} ==> (PREMIADA_6)" >> resultado_mega_virada.txt
		  seis=$[$seis+1]
	else
		  echo "${j1} ==> $cont2 acertos"
		  echo "${j1} ==> $cont2 acertos" >> resultado_mega_virada.txt
		  zero=$[$zero+1]
	fi
	cont2=0
	acima1=0
	abaixo1=0
	acima2=0
	abaixo2=0
	
done < apostas_mega_virada.txt
echo
echo "0 acerto: $zero"
echo "1 acerto: $um"
echo "2 acertos: $dois"
echo "3 acertos: $tres"
echo "4 acertos: $quatro"
echo "5 acertos: $cinco"
echo "6 acertos: $seis"
echo
echo "Joguei 1 acima da dezena premiada: $acima1_acumulado"
echo "Joguei 1 abaixo da dezena premiada: $abaixo1_acumulado"
echo "Joguei 2 acima da dezena premiada: $acima2_acumulado"
echo "Joguei 2 abaixo da dezena premiada: $abaixo2_acumulado"
echo " " >> resultado_mega_virada.txt
echo "0 acerto: $zero" >> resultado_mega_virada.txt
echo "1 acerto: $um" >> resultado_mega_virada.txt
echo "2 acertos: $dois" >> resultado_mega_virada.txt
echo "3 acertos: $tres" >> resultado_mega_virada.txt
echo "4 acertos: $quatro" >> resultado_mega_virada.txt
echo "5 acertos: $cinco" >> resultado_mega_virada.txt
echo "6 acertos: $seis" >> resultado_mega_virada.txt
echo "" >> resultado_mega_virada.txt
echo "Joguei 1 acima da dezena premiada: $acima1_acumulado" \
>> resultado_mega_virada.txt
echo "Joguei 1 abaixo da dezena premiada: $abaixo1_acumulado" \
>> resultado_mega_virada.txt
echo "Joguei 2 acima da dezena premiada: $acima2_acumulado" \
>> resultado_mega_virada.txt
echo "Joguei 2 abaixo da dezena premiada: $abaixo2_acumulado" \
>> resultado_mega_virada.txt