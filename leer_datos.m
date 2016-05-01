function [ ] = leer_datos(filename )
M = csvread(filename);
m = M(1,2); %numero de vehiculos
n = M(1,3); %numero de clientes
p = M(1,4); %numero de dias del periodo


end

