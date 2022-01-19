#!/bin/zsh

##################################################################################
## script_quina.sh - Shell script para loteria Quina							##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 29/11/2021													##
## Descrição:	- Fornece todas as combinações da loteria Quina					##
##		- Distribui em 4 arquivos com 5 milhões e mais um com 4.040.016			##
##		- Total de combinações: 24.040.016										##
## Exemplo de uso: ./script_mega.sh												##
##################################################################################

contador=0
for dez1 in $(seq 1 80)
	do
	for dez2 in $(seq $[$dez1+1] 80)
		do
		for dez3 in $(seq $[$dez2+1] 80)
			do
			for dez4 in $(seq $[$dez3+1] 80)
				do
				for dez5 in $(seq $[$dez4+1] 80)
						do
						contador=$[$contador+1]
						if [ $contador -le 5000000 ] # até 5 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5" >> \
							/home/junior/Documentos/Meus_scripts/Loterias/quina/\
							quina_0_5.txt
						elif [ $contador -gt 5000000 -a $contador -le 10000000 ] # 5 milhões e um até 10 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5" >> \
							/home/junior/Documentos/Meus_scripts/Loterias/quina/\
							quina_5_10.txt
						elif [ $contador -gt 10000000 -a $contador -le 15000000 ] # 10 milhões e um até 15 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5" >> \
							/home/junior/Documentos/Meus_scripts/Loterias/quina/\
							quina_10_15.txt
						elif [ $contador -gt 15000000 -a $contador -le 20000000 ] # 15 milhões e um até 20 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5" >> \
							/home/junior/Documentos/Meus_scripts/Loterias/quina/\
							quina_15_20.txt
						else
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5" >> \
							/home/junior/Documentos/Meus_scripts/Loterias/quina/\
							quina_20_mais.txt
						fi
				done
			done
		done
	done
done