#!/bin/zsh
##################################################################################
## calc_posicao.sh - Script para loteria Megasena								##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 29/12/2021													##
## Descrição:																	##
##		- calcula a posição de um jogo											##
## Requisitos:																	##
##		- Necessita do programa bc instalado na máquina 						##
## Exemplo de uso: ./calc_posicao.sh											##
##################################################################################

#Jogo entrando como parâmetro
j=($1 $2 $3 $4 $5 $6)

#Atribuo à $max o valor do total de dezenas da megasena. Será preciso ao 
# subtrir a variavel $n logo a frente
max=60

j1=$j[1];j2=$j[2];j3=$j[3];j4=$j[4];j5=$j[5];j6=$j[6]
if [ $j[1] -gt 1 ]; then
	while [ $j1 -gt 1 ]; do
		j1=$[$j1-1]
		n=$[$max-$j1]
		p=5
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
#echo "O valor de \$c1 é: $c"

j1=$j[1];j2=$j[2];j3=$j[3];j4=$j[4];j5=$j[5];j6=$j[6]
if [[ $j[2]-$j[1] -gt 1 ]]; then
	cont=$[($j2-$j1)-1]
	#echo $cont
	#exit 0
	while [ $cont -gt 0 ]; do
		j2=$[$j2-1]
		n=$[$max-$j2]
		p=4
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
#echo "O valor de \$c2 é: $c"

j1=$j[1];j2=$j[2];j3=$j[3];j4=$j[4];j5=$j[5];j6=$j[6]
if [[ $j[3]-$j[2] -gt 1 ]];then
	cont=$[($j3-$j2)-1]
	while [ $cont -gt 0 ]; do
		j3=$[$j3-1]
		n=$[$max-$j3]
		p=3
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
#echo "O valor de \$c3 é: $c"

j1=$j[1];j2=$j[2];j3=$j[3];j4=$j[4];j5=$j[5];j6=$j[6]
if [[ $j[4]-$j[3] -gt 1 ]];then
	cont=$[($j4-$j3)-1]
	while [ $cont -gt 0 ]; do
		j4=$[$j4-1]
		n=$[$max-$j4]
		p=2
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
#echo "O valor de \$c4 é: $c"

j1=$j[1];j2=$j[2];j3=$j[3];j4=$j[4];j5=$j[5];j6=$j[6]
if [[ $j[5]-$j[4] -gt 1 ]];then
	cont=$[($j5-$j4)-1]
	while [ $cont -gt 0 ]; do
		j5=$[$j5-1]
		n=$[$max-$j5]
		p=1
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
#echo "O valor de \$c5 é: $c"

j1=$j[1];j2=$j[2];j3=$j[3];j4=$j[4];j5=$j[5];j6=$j[6]
if [[ $j[6]-$j[5] -gt 1 ]];then
	cont=$[($j6-$j5)-1]
	while [ $cont -gt 0 ]; do
		j6=$[$j6-1]
		n=$[$max-$j6]
		p=0
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
#echo "O valor de \$c6 é: $c"
posicao=$[$c+1]
#echo "A posição do jogo $j é: $posicao"
echo "$posicao"