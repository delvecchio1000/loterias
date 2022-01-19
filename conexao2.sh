#!/bin/zsh
##################################################################################
## conexao2.sh - Shell script para loterias Caixa em modo WEB		        	##
## Autor: Benedito Del Vecchio Junior					                    	##
## Data de criação: 19/01/2022						                        	##
## Descrição:									                                ##
##		- testa a conexão com o site www.mazusoft.com.br	                	##
## Requisitos:	- necessita do programa lynx instalado			            	##
##		- apache configurado e rodando				                        	##
##		- folha de estilo css definida				                        	##
##      - bootstrap 5                                                           ##
## Exemplo de uso: ./conexao2.sh						                        ##
##################################################################################
echo "Content-type: text/html"
echo

# Teste da conexão
titulo="Conexão com Mazusoft"
ping -w1 www.mazusoft.com.br > /dev/null 2>&1
		if [ $? -ne 0 ];then
			resposta="Sem conexão com MAZUSOFT.COM.BR"
		else
			resposta="Conexão OK!"
			data=$(date +"%d/%m/%Y às %T")
		fi

cat <<HTML
<!DOCTYPE html>
<html lang="pt-br">
 	<head>
  	  <meta charset="UTF-8">
     	  <meta http-equiv="X-UA-Compatible" content="IE=edge">
     	  <meta name="viewport" content="width=device-width, \
initial-scale=1.0">
     	  <title>$titulo</title>
		  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
          <link href="estilos_css/conexao.css" rel="stylesheet">
 	</head>

 	<body>
	 
        <div class="container">     
            <div class="card">
                <div class="card-body">
                 $resposta<br>
		         $data
                </div>
            </div>
        </div>
	
 	</body>
</html>
HTML


