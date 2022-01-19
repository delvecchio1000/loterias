#!/bin/zsh
##################################################################################
## fatorial.sh - Script para loteria Megasena                                   ##
## Autor: Benedito Del Vecchio Junior						                    ##
## Data de criação: 29/12/2021							                        ##
## Descrição:									                                ##
##		- Calcula o fatorial de um número positivo e diferente de zero 	        ##
## Requisitos:									                                ##
##		- Necessita do programa bc instalado na máquina                         ##
## Exemplo de uso: ./fatorial.sh                                                ##
##################################################################################

numero=$1
for ((i=$numero-1;i>0;i--))
do
numero=$(bc <<< "$numero*$i")
done
fat=$numero
echo "$fat"