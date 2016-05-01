function [ ] = leer_datos(filename )
M = csvread(filename);
m = M(1,2); %numero de vehiculos
n = M(1,3); %numero de clientes
p = M(1,4); %numero de dias del periodo

Q = M(2,2); %capacidad, basta con leer uno porque todos los vehiculos tienen la misma capacidad

%Leer las posiciones de los nodos

pos = M(p+2:end,2:3)

%Crear matriz de distancias

for i=1:n+1
    for j = i:n+1
        d(i,j) = sqrt((pos(i,1)-pos(j,1))^2+(pos(i,2)-pos(j,2))^2);
    end
end

for j=1:n+1
    for i=j:n+1
        d(i,j) = d(j,i);
    end
end




end


