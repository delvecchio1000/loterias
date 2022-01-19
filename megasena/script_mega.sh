#!/bin/zsh

##################################################################################
## script_mega.sh - Shell script para loteria Megasena							##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 20/11/2021													##
## Descrição:	- Fornece todas as combinações da loteria Megasena				##
##		- Distribui em 10 arquivos com 5 milhões e mais um com 63860			##
## Exemplo de uso: ./script_mega.sh												##
##################################################################################

contador=0
for dez1 in $(seq 1 60)
	do
	for dez2 in $(seq $[$dez1+1] 60)
		do
		for dez3 in $(seq $[$dez2+1] 60)
			do
			for dez4 in $(seq $[$dez3+1] 60)
				do
				for dez5 in $(seq $[$dez4+1] 60)
					do
					for dez6 in $(seq $[$dez5+1] 60)
						do
						contador=$[$contador+1]
						if [ $contador -le 5000000 ] # até 5 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_0_5.txt
						elif [ $contador -gt 5000000 -a $contador -le 10000000 ] # 5 milhões e um até 10 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_5_10.txt
						elif [ $contador -gt 10000000 -a $contador -le 15000000 ] # 10 milhões e um até 15 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_10_15.txt
						elif [ $contador -gt 15000000 -a $contador -le 20000000 ] # 15 milhões e um até 20 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_15_20.txt
						elif [ $contador -gt 20000000 -a $contador -le 25000000 ] # 20 milhões e um até 25 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_20_25.txt
						elif [ $contador -gt 25000000 -a $contador -le 30000000 ] # 25 milhões e um até 30 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_25_30.txt
						elif [ $contador -gt 30000000 -a $contador -le 35000000 ] # 30 milhões e um até 35 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_30_35.txt
						elif [ $contador -gt 35000000 -a $contador -le 40000000 ] # 35 milhões e um até 40 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_35_40.txt
						elif [ $contador -gt 4000000 -a $contador -le 45000000 ] # 40 milhões e um até 45 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_40_45.txt
						elif [ $contador -gt 45000000 -a $contador -le 50000000 ] # 45 milhões e um até 50 milhões
							then
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_45_50.txt
						else
							echo "$contador $dez1 $dez2 $dez3 $dez4 $dez5 $dez6" >> /home/junior/Documentos/Meus_scripts/Loterias/megasena/megasena_50_mais.txt
						fi
					done
				done
			done
		done
	done
done