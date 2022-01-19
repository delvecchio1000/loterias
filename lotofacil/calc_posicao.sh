#!/bin/zsh
##################################################################################
## calc_posicao.sh - Script para loteria LotoFácil				##
## Autor: Benedito Del Vecchio Junior						##
## Data de criação: 29/12/2021							##
## Descrição:									##
##		- calcula a posição de um jogo					##
## Requisitos:									##
##		- Necessita do programa bc instalado na máquina 		##
## Exemplo de uso: ./calc_posicao.sh						##
##################################################################################

#Jogo entrando como parâmetro
j=($1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15})

#Atribuo à $max o valor do total de dezenas da megasena. Será preciso ao 
# subtrir a variavel $n logo a frente
max=25

j1=$j[1];j2=$j[2];j3=$j[3];j4=$j[4];j5=$j[5];j6=$j[6];j7=$j[7];j8=$j[8]
j9=$j[9];j10=$j[10];j11=$j[11];j12=$j[12];j13=$j[13];j14=$j[14];j15=$j[15]

if [ $j[1] -gt 1 ]; then
	while [ $j1 -gt 1 ]; do
		j1=$[$j1-1]
		n=$[$max-$j1]
		p=14
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j1=$j[1] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c1 é: $c"

if [[ $j[2]-$j[1] -gt 1 ]]; then
	cont=$[($j2-$j1)-1]
	#echo $cont
	#exit 0
	while [ $cont -gt 0 ]; do
		j2=$[$j2-1]
		n=$[$max-$j2]
		p=13
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j2=$j[2] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c2 é: $c"

if [[ $j[3]-$j[2] -gt 1 ]];then
	cont=$[($j3-$j2)-1]
	while [ $cont -gt 0 ]; do
		j3=$[$j3-1]
		n=$[$max-$j3]
		p=12
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j3=$j[3] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c3 é: $c"

if [[ $j[4]-$j[3] -gt 1 ]];then
	cont=$[($j4-$j3)-1]
	while [ $cont -gt 0 ]; do
		j4=$[$j4-1]
		n=$[$max-$j4]
		p=11
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j4=$j[4] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c4 é: $c"

if [[ $j[5]-$j[4] -gt 1 ]];then
	cont=$[($j5-$j4)-1]
	while [ $cont -gt 0 ]; do
		j5=$[$j5-1]
		n=$[$max-$j5]
		p=10
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j5=$j[5] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c5 é: $c"

if [[ $j[6]-$j[5] -gt 1 ]];then
	cont=$[($j6-$j5)-1]
	while [ $cont -gt 0 ]; do
		j6=$[$j6-1]
		n=$[$max-$j6]
		p=9
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j6=$j[6] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c6 é: $c"

if [[ $j[7]-$j[6] -gt 1 ]];then
	cont=$[($j7-$j6)-1]
	while [ $cont -gt 0 ]; do
		j7=$[$j7-1]
		n=$[$max-$j7]
		p=8
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j7=$j[7] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c7 é: $c"

if [[ $j[8]-$j[7] -gt 1 ]];then
	cont=$[($j8-$j7)-1]
	while [ $cont -gt 0 ]; do
		j8=$[$j8-1]
		n=$[$max-$j8]
		p=7
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j8=$j[8] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c8 é: $c"

if [[ $j[9]-$j[8] -gt 1 ]];then
	cont=$[($j9-$j8)-1]
	while [ $cont -gt 0 ]; do
		j9=$[$j9-1]
		n=$[$max-$j9]
		p=6
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j9=$j[9] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c9 é: $c"

if [[ $j[10]-$j[9] -gt 1 ]];then
	cont=$[($j10-$j9)-1]
	while [ $cont -gt 0 ]; do
		j10=$[$j10-1]
		n=$[$max-$j10]
		p=5
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j10=$j[10] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c10é: $c"

if [[ $j[11]-$j[10] -gt 1 ]];then
	cont=$[($j11-$j10)-1]
	while [ $cont -gt 0 ]; do
		j11=$[$j11-1]
		n=$[$max-$j11]
		p=4
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j11=$j[11] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c11 é: $c"

if [[ $j[12]-$j[11] -gt 1 ]];then
	cont=$[($j12-$j11)-1]
	while [ $cont -gt 0 ]; do
		j12=$[$j12-1]
		n=$[$max-$j12]
		p=3
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j12=$j[12] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c12 é: $c"

if [[ $j[13]-$j[12] -gt 1 ]];then
	cont=$[($j13-$j12)-1]
	while [ $cont -gt 0 ]; do
		j13=$[$j13-1]
		n=$[$max-$j13]
		p=2
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j13=$j[13] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c13 é: $c"

if [[ $j[14]-$j[13] -gt 1 ]];then
	cont=$[($j14-$j13)-1]
	while [ $cont -gt 0 ]; do
		j14=$[$j14-1]
		n=$[$max-$j14]
		p=1
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
j14=$j[14] # Recuperando valor original para uso na próxima etapa
#echo "O valor de \$c14 é: $c"

if [[ $j[15]-$j[14] -gt 1 ]];then
	cont=$[($j15-$j14)-1]
	while [ $cont -gt 0 ]; do
		j15=$[$j15-1]
		n=$[$max-$j15]
		p=0
		cont=$[$cont-1]
		c=$[$c+$(./combinacao.sh $n $p)]
	done
fi
#echo "O valor de \$c15 é: $c"


posicao=$[$c+1]
#echo "A posição do jogo $j é: $posicao"
echo "$posicao"