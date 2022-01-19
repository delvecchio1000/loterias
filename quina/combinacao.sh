#!/bin/zsh
##################################################################################
## combinacao.sh - Script para loteria Quina					##
## Autor: Benedito Del Vecchio Junior						##
## Data de criação: 29/12/2021							##
## Descrição:									##
##		- executa a fórmula de Combinação Simples: Cn,p=n!/p!(n–p)!	##
## Requisitos:									##
##		- Necessita do programa bc instalado na máquina 		##
## Exemplo de uso: ./combinacao.sh						##
##################################################################################
#Fórmula de combinação
#Combinação de n, tomado de p a p = n!/p!(n-p)!
#Cn,p = n!/p!(n-p)!

#Fatorial de n ############################
n=$1
numero=$n
for ((i=$numero-1;i>0;i--))
do
numero=$(bc <<< "$numero*$i")
done
n_fat=$numero

#Fatorial de p ############################
p=$2
numero=$p
for ((i=$numero-1;i>0;i--))
do
numero=$(bc <<< "$numero*$i")
done
p_fat=$numero
if [ $p -eq 0 ]; then
p_fat=1
fi

#Cálculo do (n-p)! #########################
subtracao=$[$n-$p]
numero=$subtracao
for ((i=$numero-1;i>0;i--))
do
numero=$(bc <<< "$numero*$i")
done
n_p_fat=$numero

#Cálculo da Combinação
c=$(bc <<< "$n_fat/($p_fat*$n_p_fat)")
echo $c