function [m,n,p,Q,d,qi,fi,aks,Ci] = leer_datos(filename )

%Funcion que lee los datos del csv con el formato establecido en
% http://neumann.hec.ca/chairedistributique/data/pvrp/old/

% INPUT:

%filename: nombre del archivo csv

% OUTPUT

% m = numero de vehiculos
% n = numero de clientes
% p = numero de dias del periodo
% Q = capacidad maxima de cada vehiculo
% d = matriz de costos 
% qi = vector de cantidades de cada cliente
% fi = vector de frecuencias de cada cliente
% aks = matriz de combinaciones de dias
% Ci = combinaciones de cada cliente

M = csvread(filename);
m = M(1,2); %numero de vehiculos
n = M(1,3); %numero de clientes
p = M(1,4); %numero de dias del periodo

Q = M(2,2); %capacidad, basta con leer uno porque todos los vehiculos tienen la misma capacidad


%renglon en el que comienzan los clientes = p+3

ini = p+2; 

pos = M(ini:end,2:3); %Leer las posiciones de los nodos

%Crear matriz de distancias

d = zeros(n+1,n+1);

for i=1:n+1
    for j = i:n+1
        d(i,j) = sqrt((pos(i,1)-pos(j,1))^2+(pos(i,2)-pos(j,2))^2);
        d(j,i) = d(i,j);
    end
end

%Leer demandas de cada cliente

qi = M(ini+1:end,5);
fi = M(ini+1:end,6);


aks_aux = cellstr(dec2bin(1:(2^p)-1)); %todas las combinaciones de dias posibles

comb = cellstr(dec2bin(M(ini+1:end,8:end),p)); %leer combinaciones y pasarlas a binario
[~,b]=ismember(comb,aks_aux);  % ver que combinacion de aks le pertence
Ci = reshape(b,n,p); %pasar a forma de matriz
aks = (dec2bin(1:(2^p)-1))';

end


