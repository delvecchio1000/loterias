#!/bin/zsh
##################################################################################
## fluxo.sh - Script para loteria Megasena					##
## Autor: Benedito Del Vecchio Junior						##
## Data de criação: 20/11/2021							##
## Descrição:									##
##		- Calcula quantas vezes o fluxo de jogo manteve e quantas	##
##		vezes inverteu							##
## Exemplo de uso: ./fluxo.sh							##
##################################################################################

ARQUIVO="estatistica1_mega.txt"
L="1"
P="100"
U="1000"
C="0"
FM="0"
FI="0"
NENHUMA=0

while read linha
do
C=$(echo "$linha" | cut -d" " -f8)

if [ "$P" -lt "$U" ] && [ "$P" -lt "$C" ] && [ "$U" -lt "$C" ]
then
FM=$[$FM+1]


elif [ "$P" -lt "$U" ] && [ "$P" -lt "$C" ] && [ "$U" -gt "$C" ]
then
FI=$[$FI+1]


elif [ "$P" -gt "$U" ] && [ "$P" -gt "$C" ] && [ "$U" -lt "$C" ]
then
FI=$[$FI+1]


elif [ "$P" -lt "$U" ] && [ "$P" -gt "$C" ] && [ "$U" -gt "$C" ]
then
FI=$[$FI+1]


elif [ "$P" -gt "$U" ] && [ "$P" -lt "$C" ] && [ "$U" -lt "$C" ]
then
FI=$[$FI+1]


elif [ "$P" -gt "$U" ] && [ "$P" -gt "$C" ] && [ "$U" -gt "$C" ]
then
FM=$[$FM+1]

else
NENHUMA=$[$NENHUMA+1]
fi

P=$U
U=$C
L=$[$L+1]

done < $ARQUIVO

echo "Fluxo Mantido: $FM"
echo "Fluxo Invertido: $FI"