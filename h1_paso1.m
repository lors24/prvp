function [f,R,psi,R_t,w,theta] = h1_paso1(n,Q_hat,m_bar,d,q,fi,I,lambda,Q)
%PARAMETROS

%n = numero de clientes 
%Q_hat = vector de cantidades posibles
%m_bar = numero de vehiculos 
%d = matriz de costos
%qi = vector de cantidades 
%fi = matriz de frecuencias
%lambda = matriz de lambdas

clientes = 1:n;

%Nueva matriz de costos modificados
d_tilde = zeros(n+1); %matriz cuadrada de n+1

for i = 1:n+1;
        for j = 1:n+1;
            d_tilde(i,j)=d(i,j)-0.5*lambda(i)-0.5*lambda(j);
        end
end

%Condicion de compatibilidad 

for i=1:n
    for j = 1:n
        if I(i,j) == 0
            d_tilde(i+1,j+1)=Inf;
        end
    end
end


q_n = length(Q_hat); %numero de cantidades posibles

%Inicia todo con infinito
f = Inf(q_n,n);
R = cell(q_n,n);

%Valores iniciales: 

for i = 1:n
    k = ismember(Q_hat,q(i));
    f(k,i) = d_tilde(1,i+1); %d_0i
    R{k,i} =[0,i];  %almacenan las rutas iniciales
end

d2= d_tilde(2:n+1,2:n+1); %quitamos la columna de ceros para los indices

%Inicializar las rutas

for j = 1: q_n
    qi = Q_hat(j);
    for i = 1:n
        indx = find(Q_hat == qi-q(i));
        if isempty(indx)==0
            ctes = clientes(setdiff(1:n,i));
            m = f(indx,setdiff(1:n,i))+d2(i,setdiff(1:n,i));
            [a,b]= min(m);
            if a ~= Inf
                f(j,i)=a;
                ant = ctes(b);
                R{j,i} = [R{indx,ant},i];
            end
        end
    end
end

%Inicia todo con infinito
psi = Inf(q_n,n);
R_t = cell(q_n,n);

% Crear matrices para almacenar costos

X = cell(n,3); %una columna para costos, otra para cantidades y otra para rutas

for i = 1:n
        [C,R2] = matrices(i,f,Q_hat,R,Q);
        X{i,1} = C;
        X{i,2} = Q{i};
        X{i,3} = R2;
end

for j = 1: length(Q_hat)
    qi = Q_hat(j);
    for i = 1:n
        [a,~] = min(X{i,1}(ismember(X{i,2},qi)));
        if(isempty(a) == 0)
            psi(j,i) = a;
            R_t{j,i} = X{i,3}{ismember(X{i,2},qi)};
        end
    end
end

%Crear variables w

w = ones(n,1);
rho = zeros(n);

%rho(j,i) numero de veces que el cliente j es visitado por la ruta i

q_min = zeros(1,n);

for i=1:n
    [a,b]=min(psi(:,i)./Q_hat');
    w(i) = q(i)*a+lambda(i+1);
    q_min(i) = Q_hat(b); %ruta q de minimo costo
    for j=1:n
        rho(j,i) = sum(R_t{b,i} == j);
    end
end

w = [lambda(1);w];

theta_1 = fi-rho*(fi.*q)./q_min';
theta_0 = m_bar -sum((fi.*q)./q_min');

theta = [theta_0;theta_1];


end

