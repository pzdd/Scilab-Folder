s = poly(0,'s');
//entrada
//funcao = 2*s^4 + 7*s^3 + 10*s^2 + 4*s + 1; instavel
//funcao = s^3 + 2.1*s^2 + 2.08*s + 0.64; instavel
//funcao = s^4 + -1.2*s^3 + 0.07*s^2 +0.3*s -0.08; estavel
//funcao = 2*s + 1; estavel
funcao = 10*s^6 + 5*s^5 + s^4 + s^3 + 2*s^2 + 3*s + 4;
//funcao = s^5 + 2*s^4 + 3*s^3 + 4*s^2 + 11*s + 10; instavel  
//vetor de coeficientes
x = coeff(funcao);
tam_x  = length(x);
//primeira condição
if abs(x(length(x))) > x(1) then
    disp("atende a condição");
    //segunda condição
    if horner(funcao,1) > 0 then
        disp("atende a segundao condicao");
        //terceira condição
        if ((horner(funcao,-1) < 0) & modulo(tam_x-1,2) == 1) | (horner(funcao,-1) > 0 & modulo(tam_x-1,2) == 0)  then
            disp("terceira condição valida");
            matriz =  zeros(tam_x,tam_x);
            //primeira e segunda linha da matriz
                for j=1:tam_x
                    matriz(1,j) = x(j);
                end
                for j=1:tam_x
                    matriz(2,j) = x((tam_x+1)-j);
                end
                contador = 1;
                cont = 1;
                ultimo = tam_x + 1;
                for z=3:tam_x
                    if modulo(z,2) == 1 then
                        for i=1:tam_x-contador
                            matriz(z,i) = det([matriz(cont,1) matriz(cont,(ultimo)-i);matriz(cont+1,1) matriz(cont+1,(ultimo)-i)]);
                        end
                        cont = cont + 2;
                        ultimo = ultimo - 1;
                       if (abs(matriz(z,1)) < abs(matriz(z,ultimo-1))) then
                            disp("não estável");
                            break;
                        end
                    end
                    if modulo(z,2) == 0 then
                        for i=1:tam_x-contador
                            matriz(z,i) = matriz(z-1,(tam_x)-i);
                        end
                        contador = contador + 1;
                    end
                //matriz(z+1,z+1) = 0;
                end
                
            disp(matriz);
        else
            disp('nao estável'); 
        end
    else
        disp('não estável');
    end
else
    disp('não estável');    
end
