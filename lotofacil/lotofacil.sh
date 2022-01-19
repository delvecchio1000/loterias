#!/bin/zsh
##################################################################################
## lotofacil.sh - Shell script para loteria Lotofácil				##
## Autor: Benedito Del Vecchio Junior						##
## Data de criação: 08/11/2021							##
## Descrição:									##
##		Caso APOSTAR:							##
##		- Não precisa saber o nº do último concurso para apostar	##
##		o sistema vai informar para o usuário				##
##		- descobre a posição do penúltimo concurso da Lotofácil,	##
##		- descobre a posição do último concurso da Lotofácil,		##
##		- decide se as próximas apostas serão maiores ou menores	##
##		que o último concurso,						##
##		- Mostra a quantidade de apostas possíveis			##
##		- Filtra 7,8,9 quantidade de ímpares				##
##		- Aplica a técnica R5						##
##		Caso CONFERIR							##
##		- totaliza a quantidade de acertos em cada aposta		##
##		- indica apostas premiadas					##
## Exemplo de uso: ./lotofacil2.sh						##
## Requisitos:	- necessita do programa bc instalado				##
##################################################################################
echo "$loto_concurso"
echo "$loto_dezenas" 
clear

echo
echo
echo "######### BEM VINDO AO SISTEMA DE APOSTAS LOTOFACIL ###########"
echo
echo
#echo "Verificando se compensa apostar no próximo concurso ..."
#sleep 1
#./se_compensa_jogar.sh
#echo
#printf "Deseja prosseguir [s/n] ";read resposta
#echo
#case $resposta in
#	s)
#		echo "Voce escolheu continuar"
#		echo ;;
#	n)
#		echo "Operacao interrompida"
#		exit 0;;
#	*)
#		echo "Opção invalida. Digite apenas s ou n"
#		exit 0;;
#esac

echo
echo "Digite 1 para Apostar"
echo "Digite 2 para Conferir"
echo
printf "Digite aqui ==> "; read acao

if [ $acao = 1 ]
	then
	echo "Voce escolheu Apostar"
	sleep 1
	./apostar.sh
	
elif [ $acao = 2 ]
	then
	echo "Voce escolheu Conferir"
	sleep 1
	./conferir.sh

else 
	echo "Opção invalida. Digite apenas 1 ou 2"
	exit 0
fi