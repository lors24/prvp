function [z] = procH1( filename, max_iter )
%INPUT

%filename: nombre del archivo csv
%max_iter: m?ximo de iteraciones

[m,n,p,Q,d,qi,fi,aks,Ci] = leer_datos(filename);
m_bar = m*p; %numero de vehiculos en todo el periodo


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

%Paso 3: crear matriz I

I = zeros(n,n);

for i=1:n
    for j=i:n
        if max(V(:,i)+V(:,j))==2 
            I(i,j) = 1;
            I(j,i) = 1;
        end
    end
end   

%Paso 4: crear vector de cantidades posibles

Q_hat = cantidades(qi, Q );

%Paso 5: dado lambda calcular solucion w y theta

lambda = zeros(n+1,1); %vector inicial de lambdas

[~,~,~,~,w,theta] = h1_paso1(n,Q_hat,m_bar,d,qi,fi,I,lambda);

%Paso 6: Calcular z(DRF(lambda))

 z_lambda = zDRF_lambda(n, m_bar,fi,w);

%Paso 7: Actualizar lambda

for i=1:max_iter
    epsilon = 1/i;
    lambda(1) = lambda(1)+2*epsilon*theta(1);
    lambda(2:end) = lambda(2:end)+2*epsilon*theta(2:end);
    [~,~,~,~,w,theta] = h1_paso1(n,Q_hat,m_bar,d,qi,fi,I,lambda);
    z_lambda(i) = zDRF_lambda(n, m_bar,fi,w);
end

z = z_lambda(end);

plot(1:max_iter,z_lambda,'b','LineWidth',2)
title(filename(1:3))
xlabel('iteraciones')
ylabel('z(DRF)')


end

