function [ Q_hat ] = cantidades(qi, Q )
%Crear todas las combinaciones de peso

%n = numero de clientes 
%Q = capacidad maxima 
%qi = vector de cantidades 

%M = (dec2bin(0:(2^n)-1)=='1');
r = min(qi):sum(qi);
Q_hat = r(r>=min(qi) & r<=Q); %cantidades posibles


end

