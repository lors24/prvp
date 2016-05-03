
function [C,R_t] = matrices(cte, f, Q_hat, R,Q)

%Funcion crea todas las combinaciones posibles de through q routes para
%cada cliente

%INPUT:

%cte: el cliente para el cual se quiere calcular las matrices
%f : funcion de q routes
%Q_hat : conjunto de todas las combinaciones posibles de cantidades 
%R: rutas 

%Nota para optimizar: unicamente hacerlo para la diagonal de abajo y luego
%invertir para la diagonal de arriba 

dim = size(Q{cte},1);

C = zeros(dim);
R_t = cell(dim);

for j = 1:length(Q_hat)
    for i = j:length(Q_hat)
        if Q{cte}(i,j) ~= 0 
        C(i,j) = f(j,cte)+f(i,cte);
        C(j,i) = C(i,j);
        R_t{i,j} = [R{i,cte}, fliplr(R{j,cte}(1:end-1))];
        R_t{j,i} = R_t{i,j};
        end
    end
end


end

