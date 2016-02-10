//Algoritmo Leverrier - Autor: Geraldo Laurentino da Silva Neto
//Trabalho da disciplina de Modelagem Integrada UFRN

//casos de teste
A=[-1 0 0;0 0 -1;0 1 -1]
//A = [0 -400;25 -250]
//identifica a ordem da matriz
y = length(diag(A))
//cria as variaveis que iram armazenar os valores de R e a(saida do trace)
for i=0:(y-1)
    execstr(strcat(["R",string(i),"=0"]))
    execstr(strcat(["azin",string(i),"=0"]))
end

R0=eye(A)
cont=0
while(cont < 3)
//ARcont = A*Rcont
execstr(strcat(["AR",string(cont), "= A*R",string(cont)]))
//trace
execstr(strcat(["x = diag(AR",string(cont),")"]))
for i=1:length(x)
    execstr(strcat(["azin",string(cont),"=azin",string(cont),"+x(",string(i),")"]))
end
execstr(strcat(["azin",string(cont),"=-azin",string(cont),"/(cont+1)"]))
//fim trace
m_id = eye(A)
//Rcont+1 = ARcont + m_id*azincont
execstr(strcat(["R",string(cont+1)," = AR",string(cont),"+ m_id*azin",string(cont)]))
cont = cont + 1
end

s = poly(0,"s")
//delta
delta = s^(y)
for i=0:(y-1)
execstr(strcat(["delta = delta + s^",string((y-1)-i),"*azin",string(i)]))
end
 
//adjunta
adj = 0
for i=0:(y-1)
execstr(strcat(["adj= adj + R",string(i),"*s^",string(y-(i+1))]))
end

resultado = adj/delta
disp("Adjunta",adj)
disp("Delta",delta)
