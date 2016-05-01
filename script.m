%Script para correr el PRVP

%Paso 1: Leer informaci?n

filename = 'p14.csv';

[m,n,p,Q,d,qi,fi,aks,Ci] = leer_datos(filename);

% Paso 2: crear matriz Vk

V = zeros(p,n); 
%matriz de dimension pxn. La entrada i,j representa si en el dia i se puede
%visitar al cliente j

for k=1:p %para cada dia
    for i=1:n %para cada cliente
        total = 0;
        for v=1:size(Ci,2) %por cada combinacion
            if Ci(i,v) ~= 0
                val = aks(k,Ci(i,v))=='1';
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