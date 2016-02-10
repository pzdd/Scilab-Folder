//rand(1) gera numero aleatorio de 0 a 1
// numero inteiro: x=rand(1)*100 --> ceil(x) arredonda para numero inteiro mais proximo
//padrao de x é radiano

function val=funcao(x,y) 
    val= sin(x).*cos(y);
endfunction

//funcao para plotar o grafico
function grafico()
    x = [intNeg:0.3:intPos]';
    y = [intNeg:0.3:intPos];
    z = sin(x)*cos(y);
    plot3d1(x,y,z);
endfunction
//gerar vetor de a ate b com passo c
// a:b:c

//gerar um filho
function filhoGerado = gerarFilho(nGens)
    for(i=1:1:nGens)
        if (rand(1)> porcentagemGenetica) then
            filhoGerado(1, $+1) = 1;
            //$ siginifica pegar o ultimo valor de coluna
        else
            filhoGerado(1, $+1) = 0;
        end  
    end    
endfunction


function dec = binarioToDecimal(binario)
    aux = '';
    for(i=1:1:nGens)
        if(binario(i) == 1) then
            aux= aux+'1';
        else
             aux= aux+'0';
        end   
    end
        dec = bin2dec(aux);
endfunction

function x = normalizar(decimal, minval, maxval, nGens)
    interval = maxval-minval
    x = minval + interval * decimal / ((2^nGens)-1);
endfunction

function val = aptidao(dec, minval, maxval, nGens)
    normalizado = normalizar(dec, minval, maxval, nGens);
    val = funcao(normalizado);
    val = 50 *(val+1);
    //val= sen(x)
endfunction

//testar gerarFilho

//funcao do scilab bin2dec('100')

//variaveis
minval=0;
maxval=2*%pi;
intNeg=minval;
intPos=maxval;
//grafico(); //chama a funcao
porcentagemGenetica = 0.5;
nGens = 8;
porcentagemCross=0.6; // nao muito pequeno se nao, nao conseguiria chear

nIndividos=6;
porcentagemMutacao = 0.01;
geracoes = 4;

//taxa de aptidao pizza
function taxaAptidaoIndividual = taxaAptidao(pop, pe)
    total = sum(pop);
    taxaAptidaoIndividual = pe/total;
endfunction

//Gerar Porcentagem
function res = roleta(populacao)
    res=[];
    for (i=1:2:10)
        r1=rand(1);
        r2=rand(1);
    
        indeceMarido = 0;
        indeceEsposa = 0;
        acumulado = 0;
    
        for i=1:1:nIndividos
             taxa = taxaAptidao(populacao, i);
             if(acumulado < r1) & (r1 <=(acumulado + taxa)) then
                indeceMarido = i; 
             end       
             if(acumulado < r2) & (r2 <=(acumulado + taxa)) then
                indeceEsposa = i; 
             end    
             acumulado = acumulado + taxa;
         end    
         res = [res; populacao(indeceMarido,:)];
         res = [res; populacao(indeceEsposa,:)];
    end
    
endfunction

////Gerar particao
//function numero = particao(nGens)
//    numero = fix(nGens*rand())+1;
//endfunction
//
//Crossover
function filhos = crossover(pai1, pai2)
    posicaoAux = rand(1) *nGens;
    posicao = ceil(posicaoAux);
    r = rand(1);
    
    if(r < porcentagemCross) then
        for(i=posicao:1:nGens)
            aux = pai1(i);
            pai1(i)= pai2(i);
            pai2(i)= aux;
        end
    end
    filhos = [pai1; pai2]; 
    return filhoCrossover;           
endfunction
function xman = mutacao(pessoa)
     
       if(rand(1)<porcentagemMutacao) then
            posicaoAux = rand(1) * nGens;
            posicao = ceil(posicaoAux);
            
            if(pessoa(i) == 1) then
                pessoa(i) = 0;
            else
                pessoa(i) = 1;
            end 
       end     
    xman = pessoa;
endfunction
function pop = gerarPopulacao()
    pop = gerarFilho(nGens);
    for (i=1:1:nIndividos-1)
        pop = [pop; gerarFilho(nGens)];
    end
endfunction

function novaPop = formarNovaGeracao(casais)
    for(i=1:2:nIndividos)
        filhos = crossover (casais(i,:),casais(i+1,:));
        novaPop(i,:) = mutacao (filhos(1,:));
        novaPop(i+1,:) = mutacao (filhos(2,:));
    end    
endfunction

function pop = final()
    populacao = gerarPopulacao();
    for(i=1:1:geracoes)
        casais = roleta(populacao);
        populacao = formarNovaGeracao(casais);
    end
    pop=populacao;    
endfunction
