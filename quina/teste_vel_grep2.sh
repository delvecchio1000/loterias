#!/bin/zsh
end_site="https://www.mazusoft.com.br/quina/resultado.php?"
scraping=$(lynx -dump -nolist "${end_site}")

dezenas_ult_concurso=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | sed 's/03/3/g' | \
sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | sed 's/07/7/g' | \
sed 's/08/8/g' | sed 's/09/9/g')

num_ult_concurso=$(echo "$scraping" | grep "Resultado da Quina " | \
cut -d" " -f4)

echo "Número do último concurso: "$num_ult_concurso""
echo "Dezenas do último concurso: "$dezenas_ult_concurso""

############### Buscando a posição do jogo do último concurso ##################
echo -n > posicao.txt
for j in $(seq 1 5)
	do
	jogo[$j]=$(echo "$scraping" | grep -A 2 "Números Sorteados" | \
	tail -n1 | sed 's/   //g' | sed 's/01/1/g' | sed 's/02/2/g' | \
	sed 's/03/3/g' | sed 's/04/4/g' | sed 's/05/5/g' | sed 's/06/6/g' | \
	sed 's/07/7/g' | sed 's/08/8/g' | sed 's/09/9/g' | cut -d" " -f"$j")
done

posicao_ult=$(grep " $jogo" /home/junior/Documentos/Meus_scripts/Loterias/quina/\
quina_0_5.txt /home/junior/Documentos/Meus_scripts/Loterias/quina/quina_5_10.txt \
/home/junior/Documentos/Meus_scripts/Loterias/quina/quina_10_15.txt /home/junior/\
Documentos/Meus_scripts/Loterias/quina/quina_15_20.txt /home/junior/Documentos/\
Meus_scripts/Loterias/quina/quina_20_mais.txt | cut -d" " -f1 | cut -d":" -f2)
echo "$posicao_ult"