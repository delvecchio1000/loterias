#!/bin/zsh

##################################################################################
## da_posicao_fornece_dezenas.sh - Shell script para loteria Megasena			##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 13/01/2022													##
## Descrição:	- Usuário fornece a posição e o programa devolve as dezenas		##
## Exemplo de uso: ./da_posicao_fornece_dezenas.sh								##
## Desvantagem: - para devolver o jogo de número 50.063.860 o programa			##
##				demorou 44 minutos												## 
##################################################################################

clear
echo "Digite a posição do jogo (1 a 50063860)"
read posicao

if [ $posicao -gt 50063860 ]
	then
	echo "Escolha uma posição entre 1 e 50063860"
	exit 0
fi

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
						if [ $contador -eq $posicao ]
							then
							echo "Essas são as dezenas para o jogo nº $posicao: \
							\n$dez1 $dez2 $dez3 $dez4 $dez5 $dez6"
							exit 0
						fi
					done
				done
			done
		done
	done
done