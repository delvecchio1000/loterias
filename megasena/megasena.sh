#!/bin/zsh
##################################################################################
## megasena.sh - Shell script para loteria Megasena				##
## Autor: Benedito Del Vecchio Junior						##
## Data de criação: 02/12/2021							##
## Descrição:									##
##		Caso APOSTAR:							##
##		- Não precisa saber o nº do último concurso para apostar	##
##		o sistema vai informar para o usuário				##
##		- descobre a posição do penúltimo concurso da Megasena,		##
##		- descobre a posição do último concurso da Megasena,		##
##		- Filtra 2,3,4 quantidade de ímpares				##
##		- Aplica a técnica R12						##
##		Caso CONFERIR							##
##		- totaliza a quantidade de acertos em cada aposta		##
##		- indica apostas premiadas					##
## Requisitos:	- necessita do programa lynx instalado				##
## Exemplo de uso: ./megasena.sh						##
##################################################################################
clear

echo
echo
echo "######### BEM VINDO AO SISTEMA DE APOSTAS MEGASENA ###########"
echo
echo

# teste de conexão com o site
#ping -w1 www.mazusoft.com.br > /dev/null 2>&1
#if [ $? -ne 0 ]
#	then
#	echo "Sem conexão com MAZUSOFT.COM.BR"
#	exit 0
#fi

#echo "Verificando se compensa apostar no próximo concurso ..."
#echo
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
	echo "Opção invalida. Digite 1 OU 2"
	exit 0
fi