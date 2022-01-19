#!/bin/zsh

##################################################################################
## busca_posicao_estatistica1.sh - Shell script para loteria Quina				##
## Autor: Benedito Del Vecchio Junior											##
## Data de criação: 30/11/2021													##
## Descrição:																	##
## 		- Procura nos arquivos base o jogo pretendido							##
## Exemplo de uso: ./busca_posicao_estatistica1.sh								##
## Requisitos:	- Arquivos base devem estar no mesmo diretório					##
##################################################################################

#linha="5716 6 26 72 76 77 1"
#	for x in /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_5_10.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_10_15.txt /home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_15_20.txt \
#	/home/junior/Documentos/Meus_scripts/Loterias/\
#quina/quina_20_mais.txt
#		do
#		grep -m1 " $linha" $x
#		#echo "$?"
#		#jogo=$(echo $linha | cut -d" " -f2-6)
#		#posicao=$(grep -m1 "$linha" $x | cut -d" " -f1)
#		#if [ $posicao > 0 ]
#		#	then	
#		#	echo "$posicao $jogo"
#		#fi
#	done


echo -n > estatistica2.txt
while read linha
	jogo=$(echo $linha | cut -d" " -f2-6)
	do
	for x in /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_5_10.txt /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_10_15.txt /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_15_20.txt /home/junior/Documentos/Meus_scripts/Loterias/\
		quina/quina_20_mais.txt
	do
		result=$(grep -m1 " $jogo" $x )
		if [ ! -s $result ]
			then
			echo "$result" >> estatistica2.txt
		fi
	done
done < estatistica1.txt