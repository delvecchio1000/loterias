#!/bin/zsh
##################################################################################
## insere_impar.sh - Script para loteria Quina									##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 29/11/2021													##
## Descrição:																	##
##		- Calcula a quantidae de dezenas ímpares em cada jogo					##
## Exemplo de uso: ./insere_impar.sh											##
##################################################################################

while read linha
	do
	impar=0
	posicao=$(echo $linha | cut -d" " -f1)
	
	########## DEZENA 1 ###########
	dez1=$(echo $linha | cut -d" " -f2)
	if [ $[$dez1 % 2] != 0 ]
		then
		impar=$[$impar+1]
	fi
	
	########## DEZENA 2 ###########
	dez2=$(echo $linha | cut -d" " -f3)
	if [ $[$dez2 % 2] != 0 ]
		then
		impar=$[$impar+1]
	fi
	
	########## DEZENA 3 ###########
	dez3=$(echo $linha | cut -d" " -f4)
	if [ $[$dez3 % 2] != 0 ]
		then
		impar=$[$impar+1]
	fi
	
	########## DEZENA 4 ###########
	dez4=$(echo $linha | cut -d" " -f5)
	if [ $[$dez4 % 2] != 0 ]
		then
		impar=$[$impar+1]
	fi
	
	########## DEZENA 5 ###########
	dez5=$(echo $linha | cut -d" " -f6)
	if [ $[$dez5 % 2] != 0 ]
		then
		impar=$[$impar+1]
	fi
	
	echo $posicao $dez1 $dez2 $dez3 $dez4 $dez5 $impar >> \
	/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5_impar.txt
done < /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_0_5.txt