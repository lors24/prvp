function [datos] = leer_datos(filename )
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
    end
end

for j=1:n+1
    for i=j:n+1
        d(i,j) = d(j,i);
    end
end

%Leer demandas de cada cliente

qs = M(ini+1:end,5);
fs = M(ini+1:end,6);
%num_combs = M(ini+1:end,7);

max_comb = max(M(ini+1:end,7)); %Maximo numero de combinaciones

%datos = {m,n,p,Q,d,qs,fs,num_combs};

aks_aux = cellstr(dec2bin(1:(2^p)-1)); %todas las combinaciones de dias posibles

comb = cellstr(dec2bin(M(ini+1:end,8:end),4)); %leer combinaciones y pasarlas a binario
[~,b]=ismember(comb,aks_aux);  % ver que combinacion de aks le pertence
b = reshape(b,n,p); %pasar a forma de matriz
aks = (dec2bin(1:(2^p)-1))';

%crear matriz Vk

V = zeros(p,n);

for k=1:p %para cada dia
    for i=1:n %para cada cliente
        total = 0;
        for v=1:max_comb %por cada combinacion
            if b(i,v) ~= 0
                val = aks(k,b(i,v))=='1';
                total = total + val;
            end
        end
        if total >= 1 
            V(k,i) = 1;
        end
    end
end

%Finalmente: crear matriz I

I = zeros(n,n);

for i=1:n
    for j=i:n
        if max(V(:,i)+V(:,j))==2 
            I(i,j) = 1;
            I(j,i) = 1;
        end
    end
end   
        
    









%Total de rutas

%res = 0

%for i = 1:n
%    res = res + nchoosek(n,1);
%end



end


