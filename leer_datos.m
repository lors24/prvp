function [ ] = leer_datos(filename )
M = csvread(filename);
m = M(1,2); %numero de vehiculos
n = M(1,3); %numero de clientes
p = M(1,4); %numero de dias del periodo

Q = M(2,2); %capacidad, basta con leer uno porque todos los vehiculos tienen la misma capacidad

%Leer las posiciones de los nodos


end

